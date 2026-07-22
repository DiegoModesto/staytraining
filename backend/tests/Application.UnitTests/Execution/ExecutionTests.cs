using Application.Execution.Notes.GetAllNotes;
using Application.Execution.Notes.GetSessionNotes;
using Application.Execution.Reports.GetWeeklyReport;
using Application.Execution.Schedule;
using Application.Execution.Sessions.Complete;
using Application.Execution.Sessions.Start;
using Application.Execution.Sessions.UpsertNote;
using Application.UnitTests.Support;
using Domain.Execution;
using Domain.Workouts;
using Shouldly;

namespace Application.UnitTests.Execution;

public class ExecutionTests
{
    private static async Task<Guid> SeedWorkout(Infra.Database.ApplicationDbContext db, Guid tenant)
    {
        var id = Guid.NewGuid();
        db.Workouts.Add(new Workout { Id = id, TenantId = tenant, OwnerStudentId = Guid.NewGuid(), Name = "W" });
        await db.SaveChangesAsync();
        return id;
    }

    [Fact]
    public async Task Schedule_notFound_when_workout_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new ScheduleWorkoutForDayCommandHandler(db, TestHarness.User(tenant));

        var result = await handler.Handle(
            new ScheduleWorkoutForDayCommand(Guid.NewGuid(), new DateOnly(2026, 1, 5)), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Workout.NotFound");
    }

    [Fact]
    public async Task Schedule_then_GetWeek_returns_item()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var workoutId = await SeedWorkout(db, tenant);

        var schedule = new ScheduleWorkoutForDayCommandHandler(db, TestHarness.User(tenant, me));
        await schedule.Handle(new ScheduleWorkoutForDayCommand(workoutId, new DateOnly(2026, 1, 7)), CancellationToken.None);

        var week = new GetWeekScheduleQueryHandler(db, TestHarness.User(tenant, me));
        var result = await week.Handle(new GetWeekScheduleQuery(new DateOnly(2026, 1, 5), null), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Count.ShouldBe(1);
        result.Value.Single().WorkoutName.ShouldBe("W");
    }

    [Fact]
    public async Task StartSession_creates_session()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var workoutId = await SeedWorkout(db, tenant);

        var handler = new StartSessionCommandHandler(db, TestHarness.User(tenant, me));
        var result = await handler.Handle(new StartSessionCommand(workoutId), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.WorkoutSessions.Single().StudentId.ShouldBe(me);
    }

    [Fact]
    public async Task UpsertNote_creates_then_updates_same_row()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var sessionId = Guid.NewGuid();
        var itemId = Guid.NewGuid();
        var exId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.WorkoutSessions.Add(new WorkoutSession
        {
            Id = sessionId, TenantId = tenant, StudentId = me, WorkoutId = Guid.NewGuid(),
            StartedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        var handler = new UpsertExerciseNoteCommandHandler(db, TestHarness.User(tenant, me));

        await handler.Handle(new UpsertExerciseNoteCommand(sessionId, itemId, exId, 20, false, null, "ok", 3, 10), CancellationToken.None);
        await handler.Handle(new UpsertExerciseNoteCommand(sessionId, itemId, exId, 25, true, "dor", "upd", 3, 8), CancellationToken.None);

        db.ExerciseNotes.Count().ShouldBe(1);
        var note = db.ExerciseNotes.Single();
        note.LoadKg.ShouldBe(25);
        note.PainFlag.ShouldBeTrue();
    }

    [Fact]
    public async Task UpsertNote_notFound_when_session_of_other_user()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.WorkoutSessions.Add(new WorkoutSession
        {
            Id = Guid.NewGuid(), TenantId = tenant, StudentId = Guid.NewGuid(), WorkoutId = Guid.NewGuid(),
            StartedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        var handler = new UpsertExerciseNoteCommandHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(
            new UpsertExerciseNoteCommand(Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid(), null, false, null, null, null, null),
            CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("WorkoutSession.NotFound");
    }

    [Fact]
    public async Task CompleteSession_sets_rating_then_rejects_double_complete()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var sessionId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.WorkoutSessions.Add(new WorkoutSession
        {
            Id = sessionId, TenantId = tenant, StudentId = me, WorkoutId = Guid.NewGuid(),
            StartedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        var handler = new CompleteSessionCommandHandler(db, TestHarness.User(tenant, me));

        var first = await handler.Handle(new CompleteSessionCommand(sessionId, 4, "bom"), CancellationToken.None);
        first.IsSuccess.ShouldBeTrue();
        db.WorkoutSessions.Single().CompletionRating.ShouldBe(4);

        var second = await handler.Handle(new CompleteSessionCommand(sessionId, 5, null), CancellationToken.None);
        second.IsFailure.ShouldBeTrue();
        second.Error.Code.ShouldBe("WorkoutSession.AlreadyCompleted");
    }

    [Fact]
    public async Task GetAllNotes_and_WeeklyReport_aggregate()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var exId = Guid.NewGuid();
        var sessionId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.WorkoutSessions.Add(new WorkoutSession
        {
            Id = sessionId, TenantId = tenant, StudentId = me, WorkoutId = Guid.NewGuid(),
            StartedAt = DateTimeOffset.UtcNow, CompletedAt = DateTimeOffset.UtcNow, CompletionRating = 4,
            Notes =
            [
                new ExerciseNote { Id = Guid.NewGuid(), WorkoutSessionId = sessionId, WorkoutItemId = Guid.NewGuid(), ExerciseId = exId, PerformedSets = 3, PerformedReps = 10, LoadKg = 30, CreatedAt = DateTimeOffset.UtcNow },
            ],
        });
        await db.SaveChangesAsync();

        var notes = new GetAllNotesQueryHandler(db, TestHarness.User(tenant, me));
        var notesResult = await notes.Handle(new GetAllNotesQuery(null, null), CancellationToken.None);
        notesResult.Value.Count.ShouldBe(1);

        var sessionNotes = new GetSessionNotesQueryHandler(db, TestHarness.User(tenant, me));
        var sessionNotesResult = await sessionNotes.Handle(new GetSessionNotesQuery(sessionId), CancellationToken.None);
        sessionNotesResult.Value.Count.ShouldBe(1);

        var report = new GetWeeklyReportQueryHandler(db, TestHarness.User(tenant, me));
        var weekStart = DateOnly.FromDateTime(DateTime.UtcNow.AddDays(-1));
        var reportResult = await report.Handle(new GetWeeklyReportQuery(weekStart, null), CancellationToken.None);

        reportResult.IsSuccess.ShouldBeTrue();
        reportResult.Value.SessionCount.ShouldBe(1);
        reportResult.Value.Exercises.Single().TotalReps.ShouldBe(10);
        reportResult.Value.AverageRating.ShouldBe(4);
    }
}
