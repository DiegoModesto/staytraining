using Application.Modalities.Create;
using Application.Modalities.Delete;
using Application.Modalities.List;
using Application.Modalities.Update;
using Application.UnitTests.Support;
using Domain.Exercises;
using Shouldly;

namespace Application.UnitTests.Modalities;

public class ModalityTests
{
    [Fact]
    public async Task Create_persists_and_rejects_duplicate_name_case_insensitive()
    {
        await using var db = TestHarness.NewContext();
        var handler = new CreateModalityCommandHandler(db);

        var first = await handler.Handle(new CreateModalityCommand("Musculação", "#4EA8FF", false, 0), CancellationToken.None);
        first.IsSuccess.ShouldBeTrue();
        db.Modalities.Count().ShouldBe(1);

        var dup = await handler.Handle(new CreateModalityCommand("musculação", "#000000", false, 1), CancellationToken.None);
        dup.IsFailure.ShouldBeTrue();
        dup.Error.Code.ShouldBe("Modality.NameNotUnique");
    }

    [Fact]
    public async Task Update_renames_and_notFound_and_conflict()
    {
        await using var db = TestHarness.NewContext();
        Guid a = TestHarness.SeedModality(db, "Boxe", isIntervalBased: true);
        Guid b = TestHarness.SeedModality(db, "Funcional");
        var handler = new UpdateModalityCommandHandler(db);

        (await handler.Handle(new UpdateModalityCommand(a, "Boxe Thai", "#FF4757", true, 0), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();

        (await handler.Handle(new UpdateModalityCommand(Guid.NewGuid(), "X", "#111111", false, 0), CancellationToken.None))
            .Error.Code.ShouldBe("Modality.NotFound");

        // Renaming b to an existing name conflicts.
        (await handler.Handle(new UpdateModalityCommand(b, "Boxe Thai", "#2FD37A", false, 1), CancellationToken.None))
            .Error.Code.ShouldBe("Modality.NameNotUnique");
    }

    [Fact]
    public async Task Delete_soft_deletes_and_blocks_when_in_use()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        Guid inUse = TestHarness.SeedModality(db, "Musculação");
        Guid free = TestHarness.SeedModality(db, "Aeróbico", isIntervalBased: true);
        db.Exercises.Add(new Exercise
        {
            Id = Guid.NewGuid(), TenantId = tenant, Name = "Supino",
            ModalityId = inUse, PrimaryMuscleGroupId = Guid.NewGuid(),
        });
        await db.SaveChangesAsync();

        var handler = new DeleteModalityCommandHandler(db);

        (await handler.Handle(new DeleteModalityCommand(inUse), CancellationToken.None))
            .Error.Code.ShouldBe("Modality.InUse");

        (await handler.Handle(new DeleteModalityCommand(free), CancellationToken.None)).IsSuccess.ShouldBeTrue();
        // Soft-deleted: filtered out of the default query.
        db.Modalities.Count().ShouldBe(1);
    }

    [Fact]
    public async Task List_orders_by_sort_order_then_name()
    {
        await using var db = TestHarness.NewContext();
        var create = new CreateModalityCommandHandler(db);
        await create.Handle(new CreateModalityCommand("Boxe", "#FF4757", true, 2), CancellationToken.None);
        await create.Handle(new CreateModalityCommand("Musculação", "#4EA8FF", false, 0), CancellationToken.None);

        var result = await new ListModalitiesQueryHandler(db).Handle(new ListModalitiesQuery(), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Count.ShouldBe(2);
        result.Value.First().Name.ShouldBe("Musculação"); // sort order 0 first
    }
}
