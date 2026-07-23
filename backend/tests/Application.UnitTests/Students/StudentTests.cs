using Application.Students.AddStudentNote;
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
