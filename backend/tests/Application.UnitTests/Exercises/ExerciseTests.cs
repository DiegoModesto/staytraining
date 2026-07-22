using Application.Exercises;
using Application.Exercises.AddMedia;
using Application.Exercises.Create;
using Application.Exercises.GetById;
using Application.Exercises.List;
using Application.MuscleGroups.List;
using Application.UnitTests.Support;
using Domain.Exercises;
using Domain.MuscleGroups;
using Shouldly;

namespace Application.UnitTests.Exercises;

public class ExerciseTests
{
    private static CreateExerciseCommand ValidCreate(Guid muscleId) => new(
        "Supino reto", "desc", ExerciseCategory.Musculacao, muscleId, null, null,
        4, 10, 90, false, null, null, null, null);

    [Fact]
    public async Task Create_persists_exercise_with_media_and_stamps_updatedAt()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new CreateExerciseCommandHandler(db, TestHarness.User(tenant));

        var cmd = ValidCreate(Guid.NewGuid()) with
        {
            Media = [new ExerciseMediaInput(ExerciseMediaKind.YoutubeUrl, null, "https://youtu.be/x", null, null)],
        };

        var result = await handler.Handle(cmd, CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var saved = db.Exercises.Single();
        saved.TenantId.ShouldBe(tenant);
        saved.Media.Count.ShouldBe(1);
        saved.UpdatedAt.ShouldNotBe(default);
    }

    [Fact]
    public async Task Create_throws_when_tenant_missing()
    {
        await using var db = TestHarness.NewContext();
        var handler = new CreateExerciseCommandHandler(db, new FakeUserContext(null, Guid.NewGuid()));

        await Should.ThrowAsync<InvalidOperationException>(
            () => handler.Handle(ValidCreate(Guid.NewGuid()), CancellationToken.None));
    }

    [Fact]
    public async Task GetById_returns_notFound_for_other_tenant()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Exercises.Add(new Exercise
        {
            Id = Guid.NewGuid(), TenantId = Guid.NewGuid(), Name = "X",
            Category = ExerciseCategory.Boxe, PrimaryMuscleGroupId = Guid.NewGuid(),
        });
        await db.SaveChangesAsync();

        var handler = new GetExerciseByIdQueryHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(new GetExerciseByIdQuery(Guid.NewGuid()), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Exercise.NotFound");
    }

    [Fact]
    public async Task GetById_returns_exercise_for_same_tenant()
    {
        var tenant = Guid.NewGuid();
        var id = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Exercises.Add(new Exercise
        {
            Id = id, TenantId = tenant, Name = "Supino",
            Category = ExerciseCategory.Musculacao, PrimaryMuscleGroupId = Guid.NewGuid(),
        });
        await db.SaveChangesAsync();

        var handler = new GetExerciseByIdQueryHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(new GetExerciseByIdQuery(id), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Name.ShouldBe("Supino");
    }

    [Fact]
    public async Task List_filters_by_tenant_and_category()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Exercises.AddRange(
            new Exercise { Id = Guid.NewGuid(), TenantId = tenant, Name = "A", Category = ExerciseCategory.Musculacao, PrimaryMuscleGroupId = Guid.NewGuid() },
            new Exercise { Id = Guid.NewGuid(), TenantId = tenant, Name = "B", Category = ExerciseCategory.Boxe, PrimaryMuscleGroupId = Guid.NewGuid() },
            new Exercise { Id = Guid.NewGuid(), TenantId = Guid.NewGuid(), Name = "C", Category = ExerciseCategory.Musculacao, PrimaryMuscleGroupId = Guid.NewGuid() });
        await db.SaveChangesAsync();

        var handler = new ListExercisesQueryHandler(db, TestHarness.User(tenant));

        var all = await handler.Handle(new ListExercisesQuery(null), CancellationToken.None);
        all.Value.Count.ShouldBe(2);

        var boxe = await handler.Handle(new ListExercisesQuery(ExerciseCategory.Boxe), CancellationToken.None);
        boxe.Value.Count.ShouldBe(1);
    }

    [Fact]
    public async Task AddMedia_returns_notFound_when_exercise_absent()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new AddExerciseMediaCommandHandler(db, TestHarness.User(tenant));

        var result = await handler.Handle(
            new AddExerciseMediaCommand(Guid.NewGuid(), ExerciseMediaKind.Gif, "k", null, "image/gif", 10),
            CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("Exercise.NotFound");
    }

    [Fact]
    public async Task AddMedia_persists_for_existing_exercise()
    {
        var tenant = Guid.NewGuid();
        var exId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.Exercises.Add(new Exercise
        {
            Id = exId, TenantId = tenant, Name = "E",
            Category = ExerciseCategory.Musculacao, PrimaryMuscleGroupId = Guid.NewGuid(),
        });
        await db.SaveChangesAsync();

        var handler = new AddExerciseMediaCommandHandler(db, TestHarness.User(tenant));
        var result = await handler.Handle(
            new AddExerciseMediaCommand(exId, ExerciseMediaKind.Gif, "k", null, "image/gif", 10),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.ExerciseMedia.Count().ShouldBe(1);
    }

    [Fact]
    public async Task ListMuscleGroups_returns_sorted()
    {
        await using var db = TestHarness.NewContext();
        db.MuscleGroups.AddRange(
            new MuscleGroup { Id = Guid.NewGuid(), Name = "Peito", BodyRegion = "Superiores" },
            new MuscleGroup { Id = Guid.NewGuid(), Name = "Quadríceps", BodyRegion = "Inferiores" });
        await db.SaveChangesAsync();

        var handler = new ListMuscleGroupsQueryHandler(db);
        var result = await handler.Handle(new ListMuscleGroupsQuery(), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Count.ShouldBe(2);
    }

    [Theory]
    [InlineData("", false)]
    [InlineData("Valid", true)]
    public void Create_validator_checks_name(string name, bool valid)
    {
        var v = new CreateExerciseCommandValidator();
        var cmd = ValidCreate(Guid.NewGuid()) with { Name = name };
        v.Validate(cmd).IsValid.ShouldBe(valid);
    }
}
