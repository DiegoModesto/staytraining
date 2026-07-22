using Application.Students.AddHealthObservation;
using Application.Students.GetById;
using Application.Students.List;
using Application.Students.Register;
using Application.UnitTests.Support;
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
            HealthObservations =
            [
                new HealthObservation { Id = Guid.NewGuid(), StudentProfileId = studentId, Kind = HealthObservationKind.HealthIssue, Title = "Ombro", CreatedAt = DateTimeOffset.UtcNow },
            ],
        });
        await db.SaveChangesAsync();

        var list = new ListStudentsQueryHandler(db, TestHarness.User(tenant));
        (await list.Handle(new ListStudentsQuery(), CancellationToken.None)).Value.Count.ShouldBe(1);

        var get = new GetStudentByIdQueryHandler(db, TestHarness.User(tenant));
        var detail = await get.Handle(new GetStudentByIdQuery(studentId), CancellationToken.None);
        detail.IsSuccess.ShouldBeTrue();
        detail.Value.HealthObservations.Count.ShouldBe(1);
    }

    [Fact]
    public async Task GetById_notFound_when_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var get = new GetStudentByIdQueryHandler(db, TestHarness.User(tenant));

        var result = await get.Handle(new GetStudentByIdQuery(Guid.NewGuid()), CancellationToken.None);
        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Student.NotFound");
    }

    [Fact]
    public async Task AddHealthObservation_persists_and_notFound_when_student_absent()
    {
        var tenant = Guid.NewGuid();
        var studentId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = studentId, TenantId = tenant, UserId = Guid.NewGuid(), FullName = "Rita" });
        await db.SaveChangesAsync();

        var handler = new AddHealthObservationCommandHandler(db, TestHarness.User(tenant));

        var ok = await handler.Handle(
            new AddHealthObservationCommand(studentId, HealthObservationKind.ProfessorNote, "Nota", "detalhe"),
            CancellationToken.None);
        ok.IsSuccess.ShouldBeTrue();
        db.HealthObservations.Count().ShouldBe(1);

        var missing = await handler.Handle(
            new AddHealthObservationCommand(Guid.NewGuid(), HealthObservationKind.HealthIssue, "X", null),
            CancellationToken.None);
        missing.IsFailure.ShouldBeTrue();
        missing.Error.Code.ShouldBe("Student.NotFound");
    }
}
