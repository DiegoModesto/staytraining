using Application.Sync;
using Application.Sync.Pull;
using Application.Sync.Push;
using Application.UnitTests.Support;
using Domain.Exercises;
using Domain.Workouts;
using Shouldly;

namespace Application.UnitTests.Sync;

public class SyncTests
{
    [Fact]
    public async Task Pull_returns_tenant_changes_and_deleted_ids()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        Guid modalityId = TestHarness.SeedModality(db);

        db.Exercises.Add(new Exercise
        {
            Id = Guid.NewGuid(), TenantId = tenant, Name = "Ativo",
            ModalityId = modalityId, PrimaryMuscleGroupId = Guid.NewGuid(),
        });
        db.Exercises.Add(new Exercise
        {
            Id = Guid.NewGuid(), TenantId = tenant, Name = "Removido", IsDeleted = true,
            ModalityId = modalityId, PrimaryMuscleGroupId = Guid.NewGuid(),
        });
        db.Workouts.Add(new Workout { Id = Guid.NewGuid(), TenantId = tenant, OwnerStudentId = me, Name = "W" });
        await db.SaveChangesAsync();

        var handler = new PullChangesQueryHandler(db, TestHarness.User(tenant, me));
        var result = await handler.Handle(new PullChangesQuery(null), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Exercises.Count.ShouldBe(1);
        result.Value.DeletedExerciseIds.Count.ShouldBe(1);
        result.Value.Workouts.Count.ShouldBe(1);
        result.Value.ServerTime.ShouldNotBe(default);
    }

    [Fact]
    public async Task Push_inserts_new_sessions_and_is_idempotent()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var sessionId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();

        var session = new SessionPushInput(
            sessionId, Guid.NewGuid(), DateTimeOffset.UtcNow, DateTimeOffset.UtcNow, 5, "ok",
            [new NotePushInput(Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid(), 20, false, null, "n", 3, 10, DateTimeOffset.UtcNow)]);

        var handler = new PushSessionsCommandHandler(db, TestHarness.User(tenant, me));

        var first = await handler.Handle(new PushSessionsCommand([session]), CancellationToken.None);
        first.Value.SessionsInserted.ShouldBe(1);
        db.WorkoutSessions.Count().ShouldBe(1);
        db.ExerciseNotes.Count().ShouldBe(1);

        // Re-push the same session id -> skipped, no duplicate.
        var second = await handler.Handle(new PushSessionsCommand([session]), CancellationToken.None);
        second.Value.SessionsInserted.ShouldBe(0);
        second.Value.SessionsSkipped.ShouldBe(1);
        db.WorkoutSessions.Count().ShouldBe(1);
    }
}
