using Application.UnitTests.Support;
using Application.Workouts;
using Application.Workouts.Templates.Create;
using Application.Workouts.Templates.GetById;
using Application.Workouts.Templates.List;
using Application.Workouts.Workouts.AddItem;
using Application.Workouts.Workouts.Create;
using Application.Workouts.Workouts.CreateFromTemplate;
using Application.Workouts.Workouts.GetById;
using Application.Workouts.Workouts.List;
using Application.Workouts.Workouts.RemoveItem;
using Application.Workouts.Workouts.ReorderItems;
using Domain.Exercises;
using Domain.Workouts;
using Shouldly;

namespace Application.UnitTests.Workouts;

public class WorkoutTests
{
    private static WorkoutItemInput Item(int order) =>
        new(Guid.NewGuid(), order, "Costas", 3, 12, 60, null, null, null, null, null);

    private static TemplateItemInput TItem(int order) =>
        new(Guid.NewGuid(), order, "Costas", 3, 12, 60, null, null, null, null, "nota");

    // ---------- Templates ----------

    [Fact]
    public async Task CreateTemplate_persists_with_items()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new CreateWorkoutTemplateCommandHandler(db, TestHarness.User(tenant));

        var result = await handler.Handle(
            new CreateWorkoutTemplateCommand("Costas e Ombro", null, ExerciseCategory.Musculacao, true, "obs",
                [TItem(1), TItem(2)]),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.WorkoutTemplates.Single().IsSystemDefault.ShouldBeTrue();
        db.TemplateItems.Count().ShouldBe(2);
    }

    [Fact]
    public async Task GetTemplateById_notFound_when_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new GetWorkoutTemplateByIdQueryHandler(db, TestHarness.User(tenant));

        var result = await handler.Handle(new GetWorkoutTemplateByIdQuery(Guid.NewGuid()), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("WorkoutTemplate.NotFound");
    }

    [Fact]
    public async Task ListTemplates_filters_systemDefaults()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.WorkoutTemplates.AddRange(
            new WorkoutTemplate { Id = Guid.NewGuid(), TenantId = tenant, Name = "Padrão", IsSystemDefault = true },
            new WorkoutTemplate { Id = Guid.NewGuid(), TenantId = tenant, Name = "Custom", IsSystemDefault = false });
        await db.SaveChangesAsync();

        var handler = new ListWorkoutTemplatesQueryHandler(db, TestHarness.User(tenant));
        var onlyDefaults = await handler.Handle(new ListWorkoutTemplatesQuery(true), CancellationToken.None);

        onlyDefaults.Value.Count.ShouldBe(1);
        onlyDefaults.Value.Single().Name.ShouldBe("Padrão");
    }

    // ---------- Workouts ----------

    [Fact]
    public async Task CreateWorkout_defaults_owner_to_currentUser_when_empty()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new CreateWorkoutCommandHandler(db, TestHarness.User(tenant, me));

        var result = await handler.Handle(
            new CreateWorkoutCommand(Guid.Empty, "Meu treino", null, null, [Item(1)]),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.Workouts.Single().OwnerStudentId.ShouldBe(me);
    }

    [Fact]
    public async Task CreateFromTemplate_copies_items_and_sets_source()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        var templateId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var template = new WorkoutTemplate
        {
            Id = templateId, TenantId = tenant, Name = "Costas e Ombro", IsSystemDefault = true,
            Items =
            [
                new TemplateItem { Id = Guid.NewGuid(), WorkoutTemplateId = templateId, ExerciseId = Guid.NewGuid(), Order = 1, Sets = 3, Reps = 10, RestSeconds = 60, CreatorNotes = "cuidado" },
            ],
        };
        db.WorkoutTemplates.Add(template);
        await db.SaveChangesAsync();

        var handler = new CreateWorkoutFromTemplateCommandHandler(db, TestHarness.User(tenant, me));
        var result = await handler.Handle(
            new CreateWorkoutFromTemplateCommand(templateId, Guid.Empty, null), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var w = db.Workouts.Single();
        w.SourceTemplateId.ShouldBe(templateId);
        w.OwnerStudentId.ShouldBe(me);
        db.WorkoutItems.Single().ProfessorComment.ShouldBe("cuidado");
    }

    [Fact]
    public async Task CreateFromTemplate_notFound_when_template_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new CreateWorkoutFromTemplateCommandHandler(db, TestHarness.User(tenant));

        var result = await handler.Handle(
            new CreateWorkoutFromTemplateCommand(Guid.NewGuid(), Guid.NewGuid(), null), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("WorkoutTemplate.NotFound");
    }

    [Fact]
    public async Task GetWorkoutById_returns_items_ordered()
    {
        var tenant = Guid.NewGuid();
        var id = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Workouts.Add(new Workout
        {
            Id = id, TenantId = tenant, OwnerStudentId = Guid.NewGuid(), Name = "W",
            Items =
            [
                new WorkoutItem { Id = Guid.NewGuid(), WorkoutId = id, ExerciseId = Guid.NewGuid(), Order = 2, Sets = 3, Reps = 10, RestSeconds = 60 },
                new WorkoutItem { Id = Guid.NewGuid(), WorkoutId = id, ExerciseId = Guid.NewGuid(), Order = 1, Sets = 3, Reps = 10, RestSeconds = 60 },
            ],
        });
        await db.SaveChangesAsync();

        var handler = new GetWorkoutByIdQueryHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(new GetWorkoutByIdQuery(id), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Items.First().Order.ShouldBe(1);
    }

    [Fact]
    public async Task ListWorkouts_filters_by_owner()
    {
        var tenant = Guid.NewGuid();
        var owner = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Workouts.AddRange(
            new Workout { Id = Guid.NewGuid(), TenantId = tenant, OwnerStudentId = owner, Name = "A" },
            new Workout { Id = Guid.NewGuid(), TenantId = tenant, OwnerStudentId = Guid.NewGuid(), Name = "B" });
        await db.SaveChangesAsync();

        var handler = new ListWorkoutsQueryHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(new ListWorkoutsQuery(owner), CancellationToken.None);

        result.Value.Count.ShouldBe(1);
    }

    [Fact]
    public async Task AddItem_appends_and_RemoveItem_deletes()
    {
        var tenant = Guid.NewGuid();
        var id = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Workouts.Add(new Workout { Id = id, TenantId = tenant, OwnerStudentId = Guid.NewGuid(), Name = "W" });
        await db.SaveChangesAsync();

        var add = new AddWorkoutItemCommandHandler(db, TestHarness.User(tenant));
        var addResult = await add.Handle(new AddWorkoutItemCommand(id, Item(0)), CancellationToken.None);
        addResult.IsSuccess.ShouldBeTrue();
        db.WorkoutItems.Count().ShouldBe(1);

        var itemId = addResult.Value;
        var remove = new RemoveWorkoutItemCommandHandler(db, TestHarness.User(tenant));
        var removeResult = await remove.Handle(new RemoveWorkoutItemCommand(id, itemId), CancellationToken.None);
        removeResult.IsSuccess.ShouldBeTrue();
        db.WorkoutItems.Count().ShouldBe(0);
    }

    [Fact]
    public async Task AddItem_notFound_when_workout_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var add = new AddWorkoutItemCommandHandler(db, TestHarness.User(tenant));

        var result = await add.Handle(new AddWorkoutItemCommand(Guid.NewGuid(), Item(1)), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Workout.NotFound");
    }

    [Fact]
    public async Task ReorderItems_updates_order()
    {
        var tenant = Guid.NewGuid();
        var id = Guid.NewGuid();
        var a = Guid.NewGuid();
        var b = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Workouts.Add(new Workout
        {
            Id = id, TenantId = tenant, OwnerStudentId = Guid.NewGuid(), Name = "W",
            Items =
            [
                new WorkoutItem { Id = a, WorkoutId = id, ExerciseId = Guid.NewGuid(), Order = 1, Sets = 1, Reps = 1, RestSeconds = 1 },
                new WorkoutItem { Id = b, WorkoutId = id, ExerciseId = Guid.NewGuid(), Order = 2, Sets = 1, Reps = 1, RestSeconds = 1 },
            ],
        });
        await db.SaveChangesAsync();

        var handler = new ReorderWorkoutItemsCommandHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(new ReorderWorkoutItemsCommand(id, [b, a]), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.WorkoutItems.Single(i => i.Id == b).Order.ShouldBe(1);
        db.WorkoutItems.Single(i => i.Id == a).Order.ShouldBe(2);
    }
}
