using Application.Students.AddStudentNote;
using Application.Students.Apportments;
using Application.Students.Ficha;
using Application.Students.GetById;
using Application.Students.List;
using Application.Students.ListNotes;
using Application.Students.Register;
using Application.UnitTests.Support;
using Domain.HealthCatalog;
using Domain.Students;
using Shouldly;

namespace Application.UnitTests.Students;

public class StudentTests
{
    [Fact]
    public async Task Register_persists_and_rejects_duplicate()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new RegisterStudentCommandHandler(db, TestHarness.User(tenant));

        var first = await handler.Handle(
            new RegisterStudentCommand(userId, "Rita Sibele Modesto", "rita@example.com", null, "força"),
            CancellationToken.None);
        first.IsSuccess.ShouldBeTrue();

        var dup = await handler.Handle(
            new RegisterStudentCommand(userId, "Rita", null, null, null), CancellationToken.None);
        dup.IsFailure.ShouldBeTrue();
        dup.Error.Code.ShouldBe("Student.AlreadyRegistered");
    }

    [Fact]
    public async Task List_and_GetById_with_health()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile
        {
            Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita",
            HealthApportments =
            [
                new HealthApportment
                {
                    Id = Guid.NewGuid(), StudentProfileId = studentId,
                    BodyPartId = Guid.NewGuid(), BodyPartName = "Ombro",
                    ProblemTypeId = Guid.NewGuid(), ProblemTypeName = "Deslocamento",
                    CreatedAt = DateTimeOffset.UtcNow,
                },
            ],
        });
        await db.SaveChangesAsync();

        var list = new ListStudentsQueryHandler(db, TestHarness.User(tenant));
        (await list.Handle(new ListStudentsQuery(), CancellationToken.None)).Value.Count.ShouldBe(1);

        var get = new GetStudentByIdQueryHandler(db, TestHarness.User(tenant), new FakeFileStorage());
        var detail = await get.Handle(new GetStudentByIdQuery(studentId), CancellationToken.None);
        detail.IsSuccess.ShouldBeTrue();
        detail.Value.HealthApportments.Count.ShouldBe(1);
    }

    [Fact]
    public async Task GetById_notFound_when_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var get = new GetStudentByIdQueryHandler(db, TestHarness.User(tenant), new FakeFileStorage());

        var result = await get.Handle(new GetStudentByIdQuery(Guid.NewGuid()), CancellationToken.None);
        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Student.NotFound");
    }

    [Fact]
    public async Task AdminAddApportment_persists_denormalized_and_writes_edit_log()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita" });
        var bodyPartId = Guid.NewGuid();
        var problemTypeId = Guid.NewGuid();
        db.BodyParts.Add(new BodyPart { Id = bodyPartId, Name = "Ombro", SortOrder = 0, CreatedAt = DateTimeOffset.UtcNow });
        db.ProblemTypes.Add(new ProblemType { Id = problemTypeId, BodyPartId = bodyPartId, Name = "Deslocamento", SortOrder = 0, CreatedAt = DateTimeOffset.UtcNow });
        await db.SaveChangesAsync();

        var handler = new AddStudentApportmentCommandHandler(db, TestHarness.User(tenant, Guid.NewGuid(), "Diego Modesto"));

        var ok = await handler.Handle(
            new AddStudentApportmentCommand(studentId, bodyPartId, problemTypeId, "sem cirurgia"),
            CancellationToken.None);
        ok.IsSuccess.ShouldBeTrue();

        HealthApportment saved = db.HealthApportments.Single();
        saved.BodyPartName.ShouldBe("Ombro");
        saved.ProblemTypeName.ShouldBe("Deslocamento");
        db.StudentEditLogs.Count().ShouldBe(1); // admin edit is audited

        var missing = await handler.Handle(
            new AddStudentApportmentCommand(Guid.NewGuid(), bodyPartId, problemTypeId, null),
            CancellationToken.None);
        missing.IsFailure.ShouldBeTrue();
        missing.Error.Code.ShouldBe("Student.NotFound");
    }

    [Fact]
    public async Task AddMyApportment_adds_to_own_ficha_and_validates_catalog_pair()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = Guid.NewGuid(), TenantId = tenant, UserId = userId, FullName = "Rita" });
        var bodyPartId = Guid.NewGuid();
        var problemTypeId = Guid.NewGuid();
        db.BodyParts.Add(new BodyPart { Id = bodyPartId, Name = "Lombar", SortOrder = 0, CreatedAt = DateTimeOffset.UtcNow });
        db.ProblemTypes.Add(new ProblemType { Id = problemTypeId, BodyPartId = bodyPartId, Name = "Hérnia", SortOrder = 0, CreatedAt = DateTimeOffset.UtcNow });
        await db.SaveChangesAsync();

        var handler = new AddMyApportmentCommandHandler(db, TestHarness.User(tenant, userId));

        var ok = await handler.Handle(new AddMyApportmentCommand(bodyPartId, problemTypeId, "sem cirurgia"), CancellationToken.None);
        ok.IsSuccess.ShouldBeTrue();
        db.HealthApportments.Single().BodyPartName.ShouldBe("Lombar");
        db.StudentEditLogs.Count().ShouldBe(0); // self edit is NOT logged

        // Problem type not belonging to the chosen body part is rejected.
        var bad = await handler.Handle(new AddMyApportmentCommand(bodyPartId, Guid.NewGuid(), null), CancellationToken.None);
        bad.Error.Code.ShouldBe("ProblemType.NotFound");
    }

    [Fact]
    public async Task RemoveMyApportment_only_removes_from_callers_own_ficha()
    {
        var tenant = Guid.NewGuid();
        var owner = Guid.NewGuid();
        var profileId = Guid.NewGuid();
        var apportId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile
        {
            Id = profileId, TenantId = tenant, UserId = owner, FullName = "Rita",
            HealthApportments =
            [
                new HealthApportment
                {
                    Id = apportId, StudentProfileId = profileId,
                    BodyPartId = Guid.NewGuid(), BodyPartName = "Ombro",
                    ProblemTypeId = Guid.NewGuid(), ProblemTypeName = "Deslocamento",
                    CreatedAt = DateTimeOffset.UtcNow,
                },
            ],
        });
        await db.SaveChangesAsync();

        // A different user cannot remove it.
        var other = new RemoveMyApportmentCommandHandler(db, TestHarness.User(tenant, Guid.NewGuid()));
        (await other.Handle(new RemoveMyApportmentCommand(apportId), CancellationToken.None)).IsFailure.ShouldBeTrue();
        db.HealthApportments.Count().ShouldBe(1);

        // The owner can.
        var self = new RemoveMyApportmentCommandHandler(db, TestHarness.User(tenant, owner));
        (await self.Handle(new RemoveMyApportmentCommand(apportId), CancellationToken.None)).IsSuccess.ShouldBeTrue();
        db.HealthApportments.Count().ShouldBe(0);
    }

    [Fact]
    public async Task AdminUpdateFicha_updates_fields_and_writes_edit_log()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita" });
        await db.SaveChangesAsync();

        var handler = new UpdateStudentFichaCommandHandler(db, TestHarness.User(tenant, Guid.NewGuid(), "Diego Modesto"));
        var result = await handler.Handle(
            new UpdateStudentFichaCommand(studentId, "Rita S.", "r@x.com", "1", "2", Domain.Profiles.BloodType.OPositive, 165, 60m, "objetivo"),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.StudentProfiles.Single().FullName.ShouldBe("Rita S.");
        db.StudentEditLogs.Single().Action.ShouldBe("FichaUpdated"); // admin edit audited
    }

    [Fact]
    public async Task AddStudentNote_persists_author_and_notFound_when_student_absent()
    {
        var tenant = Guid.NewGuid();
        var professorId = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita" });
        await db.SaveChangesAsync();

        var handler = new AddStudentNoteCommandHandler(db, TestHarness.User(tenant, professorId, "Diego Modesto"));

        var ok = await handler.Handle(new AddStudentNoteCommand(studentId, "Aluna dedicada."), CancellationToken.None);
        ok.IsSuccess.ShouldBeTrue();

        StudentNote note = db.StudentNotes.Single();
        note.AuthorUserId.ShouldBe(professorId);
        note.AuthorName.ShouldBe("Diego Modesto");
        note.Content.ShouldBe("Aluna dedicada.");

        var missing = await handler.Handle(new AddStudentNoteCommand(Guid.NewGuid(), "x"), CancellationToken.None);
        missing.IsFailure.ShouldBeTrue();
        missing.Error.Code.ShouldBe("Student.NotFound");
    }

    [Fact]
    public async Task AddStudentNote_scopes_to_workout_when_workoutId_given()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        var workoutId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita" });
        await db.SaveChangesAsync();

        var add = new AddStudentNoteCommandHandler(db, TestHarness.User(tenant, Guid.NewGuid(), "Diego"));
        await add.Handle(new AddStudentNoteCommand(studentId, "geral"), CancellationToken.None);
        await add.Handle(new AddStudentNoteCommand(studentId, "do treino", workoutId), CancellationToken.None);

        var list = await new ListStudentNotesQueryHandler(db, TestHarness.User(tenant))
            .Handle(new ListStudentNotesQuery(studentId), CancellationToken.None);

        list.Value.Count(n => n.WorkoutId == null).ShouldBe(1);
        list.Value.Count(n => n.WorkoutId == workoutId).ShouldBe(1);
    }

    [Fact]
    public async Task AddStudentNote_defaults_author_name_when_token_has_none()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita" });
        await db.SaveChangesAsync();

        var handler = new AddStudentNoteCommandHandler(db, TestHarness.User(tenant));

        (await handler.Handle(new AddStudentNoteCommand(studentId, "nota"), CancellationToken.None)).IsSuccess.ShouldBeTrue();
        db.StudentNotes.Single().AuthorName.ShouldBe("Professor");
    }

    [Fact]
    public async Task ListStudentNotes_returns_tenant_scoped_and_newest_first()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile
        {
            Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita",
            Notes =
            [
                new StudentNote { Id = Guid.NewGuid(), StudentProfileId = studentId, AuthorUserId = Guid.NewGuid(), AuthorName = "A", Content = "antiga", CreatedAt = DateTimeOffset.UtcNow.AddDays(-1) },
                new StudentNote { Id = Guid.NewGuid(), StudentProfileId = studentId, AuthorUserId = Guid.NewGuid(), AuthorName = "B", Content = "nova", CreatedAt = DateTimeOffset.UtcNow },
            ],
        });
        await db.SaveChangesAsync();

        var handler = new ListStudentNotesQueryHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(new ListStudentNotesQuery(studentId), CancellationToken.None);
        result.IsSuccess.ShouldBeTrue();
        result.Value.Count.ShouldBe(2);
        result.Value.First().Content.ShouldBe("nova");

        // A professor from another tenant sees nothing.
        var otherTenant = new ListStudentNotesQueryHandler(db, TestHarness.User(Guid.NewGuid()));
        (await otherTenant.Handle(new ListStudentNotesQuery(studentId), CancellationToken.None)).Value.Count.ShouldBe(0);
    }
}
