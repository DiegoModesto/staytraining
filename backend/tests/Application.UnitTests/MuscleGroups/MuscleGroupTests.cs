using Application.MuscleGroups.Create;
using Application.MuscleGroups.Delete;
using Application.MuscleGroups.Update;
using Application.UnitTests.Support;
using Domain.Exercises;
using Domain.MuscleGroups;
using Shouldly;

namespace Application.UnitTests.MuscleGroups;

public class MuscleGroupTests
{
    [Fact]
    public async Task Create_persists_and_rejects_duplicate()
    {
        await using var db = TestHarness.NewContext();
        var handler = new CreateMuscleGroupCommandHandler(db);

        (await handler.Handle(new CreateMuscleGroupCommand("Peito", "Superiores"), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();

        (await handler.Handle(new CreateMuscleGroupCommand("peito", "Superiores"), CancellationToken.None))
            .Error.Code.ShouldBe("MuscleGroup.NameNotUnique");
    }

    [Fact]
    public async Task Update_renames_and_notFound()
    {
        await using var db = TestHarness.NewContext();
        var id = Guid.NewGuid();
        db.MuscleGroups.Add(new MuscleGroup { Id = id, Name = "Peito", BodyRegion = "Superiores", CreatedAt = DateTimeOffset.UtcNow });
        await db.SaveChangesAsync();
        var handler = new UpdateMuscleGroupCommandHandler(db);

        (await handler.Handle(new UpdateMuscleGroupCommand(id, "Peitoral", "Superiores"), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();
        db.MuscleGroups.Single().Name.ShouldBe("Peitoral");

        (await handler.Handle(new UpdateMuscleGroupCommand(Guid.NewGuid(), "X", "Y"), CancellationToken.None))
            .Error.Code.ShouldBe("MuscleGroup.NotFound");
    }

    [Fact]
    public async Task Delete_blocks_when_used_as_primary_or_secondary()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var primary = Guid.NewGuid();
        var secondary = Guid.NewGuid();
        var free = Guid.NewGuid();
        db.MuscleGroups.AddRange(
            new MuscleGroup { Id = primary, Name = "Peito", BodyRegion = "Sup", CreatedAt = DateTimeOffset.UtcNow },
            new MuscleGroup { Id = secondary, Name = "Tríceps", BodyRegion = "Sup", CreatedAt = DateTimeOffset.UtcNow },
            new MuscleGroup { Id = free, Name = "Panturrilha", BodyRegion = "Inf", CreatedAt = DateTimeOffset.UtcNow });
        db.Exercises.Add(new Exercise
        {
            Id = Guid.NewGuid(), TenantId = tenant, Name = "Supino",
            ModalityId = TestHarness.SeedModality(db), PrimaryMuscleGroupId = primary,
            SecondaryMuscleGroupIds = [secondary],
        });
        await db.SaveChangesAsync();

        var handler = new DeleteMuscleGroupCommandHandler(db);

        (await handler.Handle(new DeleteMuscleGroupCommand(primary), CancellationToken.None))
            .Error.Code.ShouldBe("MuscleGroup.InUse");
        (await handler.Handle(new DeleteMuscleGroupCommand(secondary), CancellationToken.None))
            .Error.Code.ShouldBe("MuscleGroup.InUse");
        (await handler.Handle(new DeleteMuscleGroupCommand(free), CancellationToken.None)).IsSuccess.ShouldBeTrue();
    }
}
