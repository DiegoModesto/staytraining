using Application.Execution.Schedule;
using Application.UnitTests.Support;
using Domain.Execution;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using Shouldly;

namespace Application.UnitTests.Execution;

public class ScheduleCalendarTests
{
    private static async Task<Guid> SeedWorkout(Infra.Database.ApplicationDbContext db, Guid tenant, Guid owner)
    {
        var id = Guid.NewGuid();
        db.Workouts.Add(new Workout { Id = id, TenantId = tenant, OwnerStudentId = owner, Name = "W" });
        await db.SaveChangesAsync();
        return id;
    }

    [Fact]
    public async Task Manager_can_schedule_for_another_student()
    {
        var tenant = Guid.NewGuid();
        var professor = Guid.NewGuid();
        var student = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var workoutId = await SeedWorkout(db, tenant, student);

        // TestHarness.User acts as a manager (student.manage granted).
        var handler = new ScheduleWorkoutForDayCommandHandler(db, TestHarness.User(tenant, professor));
        var result = await handler.Handle(
            new ScheduleWorkoutForDayCommand(workoutId, new DateOnly(2026, 1, 7), student), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var schedule = await db.WorkoutSchedules.SingleAsync();
        schedule.StudentId.ShouldBe(student); // assigned to the student, not the professor
    }

    [Fact]
    public async Task Plain_student_scheduling_for_another_falls_back_to_self()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var other = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var workoutId = await SeedWorkout(db, tenant, me);

        var handler = new ScheduleWorkoutForDayCommandHandler(db, TestHarness.Student(tenant, me));
        await handler.Handle(
            new ScheduleWorkoutForDayCommand(workoutId, new DateOnly(2026, 1, 7), other), CancellationToken.None);

        var schedule = await db.WorkoutSchedules.SingleAsync();
        schedule.StudentId.ShouldBe(me); // student.manage missing => forced to caller
    }

    [Fact]
    public async Task JustifySkip_sets_status_and_reason()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var scheduleId = await SeedSchedule(db, tenant, me, new DateOnly(2026, 1, 7));

        var handler = new JustifySkipScheduleCommandHandler(db, TestHarness.Student(tenant, me));
        var result = await handler.Handle(
            new JustifySkipScheduleCommand(scheduleId, "feriado", "Feriado nacional"), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var s = await db.WorkoutSchedules.SingleAsync();
        s.Status.ShouldBe(ScheduleStatus.Skipped);
        s.JustificationReason.ShouldBe("feriado");
        s.JustificationNote.ShouldBe("Feriado nacional");
    }

    [Fact]
    public async Task Justify_on_another_students_schedule_is_notFound_for_plain_student()
    {
        var tenant = Guid.NewGuid();
        var owner = Guid.NewGuid();
        var intruder = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var scheduleId = await SeedSchedule(db, tenant, owner, new DateOnly(2026, 1, 7));

        var handler = new JustifySkipScheduleCommandHandler(db, TestHarness.Student(tenant, intruder));
        var result = await handler.Handle(
            new JustifySkipScheduleCommand(scheduleId, "doenca", null), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("WorkoutSchedule.NotFound");
    }

    [Fact]
    public async Task Swap_creates_pending_new_day_and_marks_original_swapped()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var scheduleId = await SeedSchedule(db, tenant, me, new DateOnly(2026, 1, 7));

        var handler = new SwapScheduleDayCommandHandler(db, TestHarness.Student(tenant, me));
        var result = await handler.Handle(
            new SwapScheduleDayCommand(scheduleId, new DateOnly(2026, 1, 9), "aparelhos ocupados", null),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var original = await db.WorkoutSchedules.SingleAsync(x => x.Id == scheduleId);
        original.Status.ShouldBe(ScheduleStatus.Swapped);
        original.SwappedToScheduleId.ShouldBe(result.Value);

        var moved = await db.WorkoutSchedules.SingleAsync(x => x.Id == result.Value);
        moved.Status.ShouldBe(ScheduleStatus.Pending);
        moved.ScheduledDate.ShouldBe(new DateOnly(2026, 1, 9));
        moved.SwappedFromScheduleId.ShouldBe(scheduleId);
        moved.WorkoutId.ShouldBe(original.WorkoutId);
    }

    [Fact]
    public async Task Delete_soft_deletes_the_schedule()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var scheduleId = await SeedSchedule(db, tenant, me, new DateOnly(2026, 1, 7));

        var handler = new DeleteScheduleCommandHandler(db, TestHarness.Student(tenant, me));
        var result = await handler.Handle(new DeleteScheduleCommand(scheduleId), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        (await db.WorkoutSchedules.IgnoreQueryFilters().SingleAsync()).IsDeleted.ShouldBeTrue();
    }

    [Fact]
    public async Task GetWeek_for_another_student_forbidden_without_student_read()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var other = Guid.NewGuid();
        await using var db = TestHarness.NewContext();

        var handler = new GetWeekScheduleQueryHandler(db, TestHarness.Student(tenant, me));
        var result = await handler.Handle(
            new GetWeekScheduleQuery(new DateOnly(2026, 1, 5), other), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Schedule.Forbidden");
    }

    [Fact]
    public async Task GetWeek_reflects_skipped_status()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var scheduleId = await SeedSchedule(db, tenant, me, new DateOnly(2026, 1, 7));
        await new JustifySkipScheduleCommandHandler(db, TestHarness.Student(tenant, me))
            .Handle(new JustifySkipScheduleCommand(scheduleId, "viagem", null), CancellationToken.None);

        var week = await new GetWeekScheduleQueryHandler(db, TestHarness.Student(tenant, me))
            .Handle(new GetWeekScheduleQuery(new DateOnly(2026, 1, 5), null), CancellationToken.None);

        week.IsSuccess.ShouldBeTrue();
        var item = week.Value.Single();
        item.Status.ShouldBe("Skipped");
        item.Completed.ShouldBeFalse();
        item.JustificationReason.ShouldBe("viagem");
    }

    [Fact]
    public async Task Completion_is_matched_per_day_not_per_week()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var workoutId = await SeedWorkout(db, tenant, me);

        // Same workout scheduled Mon and Wed; only Mon has a completed session.
        var mon = new DateOnly(2026, 1, 5);
        var wed = new DateOnly(2026, 1, 7);
        db.WorkoutSchedules.Add(new WorkoutSchedule { Id = Guid.NewGuid(), TenantId = tenant, StudentId = me, WorkoutId = workoutId, ScheduledDate = mon, CreatedAt = DateTimeOffset.UtcNow });
        db.WorkoutSchedules.Add(new WorkoutSchedule { Id = Guid.NewGuid(), TenantId = tenant, StudentId = me, WorkoutId = workoutId, ScheduledDate = wed, CreatedAt = DateTimeOffset.UtcNow });
        db.WorkoutSessions.Add(new WorkoutSession
        {
            Id = Guid.NewGuid(), TenantId = tenant, StudentId = me, WorkoutId = workoutId,
            StartedAt = new DateTimeOffset(mon.ToDateTime(new TimeOnly(17, 0)), TimeSpan.Zero),
            CompletedAt = new DateTimeOffset(mon.ToDateTime(new TimeOnly(18, 0)), TimeSpan.Zero),
            CreatedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        var week = await new GetWeekScheduleQueryHandler(db, TestHarness.Student(tenant, me))
            .Handle(new GetWeekScheduleQuery(new DateOnly(2026, 1, 5), null), CancellationToken.None);

        week.IsSuccess.ShouldBeTrue();
        week.Value.Single(x => x.Date == mon).Completed.ShouldBeTrue();
        week.Value.Single(x => x.Date == wed).Completed.ShouldBeFalse(); // not completed just because Monday was
    }

    private static async Task<Guid> SeedSchedule(
        Infra.Database.ApplicationDbContext db, Guid tenant, Guid student, DateOnly date)
    {
        var workoutId = await SeedWorkout(db, tenant, student);
        var id = Guid.NewGuid();
        db.WorkoutSchedules.Add(new WorkoutSchedule
        {
            Id = id,
            TenantId = tenant,
            StudentId = student,
            WorkoutId = workoutId,
            ScheduledDate = date,
            Status = ScheduleStatus.Pending,
            CreatedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();
        return id;
    }
}
