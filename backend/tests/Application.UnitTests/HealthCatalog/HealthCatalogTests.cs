using Application.HealthCatalog.BodyParts;
using Application.HealthCatalog.List;
using Application.HealthCatalog.ProblemTypes;
using Application.UnitTests.Support;
using Domain.HealthCatalog;
using Domain.Students;
using Shouldly;

namespace Application.UnitTests.HealthCatalog;

public class HealthCatalogTests
{
    [Fact]
    public async Task Create_bodyPart_then_problemType_and_list_groups_them()
    {
        await using var db = TestHarness.NewContext();

        var bp = await new CreateBodyPartCommandHandler(db).Handle(new CreateBodyPartCommand("Ombro"), CancellationToken.None);
        bp.IsSuccess.ShouldBeTrue();

        var pt = await new CreateProblemTypeCommandHandler(db)
            .Handle(new CreateProblemTypeCommand(bp.Value, "Deslocamento"), CancellationToken.None);
        pt.IsSuccess.ShouldBeTrue();

        var list = await new ListHealthCatalogQueryHandler(db).Handle(new ListHealthCatalogQuery(), CancellationToken.None);
        list.Value.Count.ShouldBe(1);
        list.Value.First().Name.ShouldBe("Ombro");
        list.Value.First().ProblemTypes.Single().Name.ShouldBe("Deslocamento");
    }

    [Fact]
    public async Task Create_problemType_fails_when_bodyPart_absent()
    {
        await using var db = TestHarness.NewContext();

        var pt = await new CreateProblemTypeCommandHandler(db)
            .Handle(new CreateProblemTypeCommand(Guid.NewGuid(), "Deslocamento"), CancellationToken.None);

        pt.Error.Code.ShouldBe("BodyPart.NotFound");
    }

    [Fact]
    public async Task Delete_is_blocked_when_referenced_by_an_apport()
    {
        await using var db = TestHarness.NewContext();
        var bodyPartId = Guid.NewGuid();
        var problemTypeId = Guid.NewGuid();
        db.BodyParts.Add(new BodyPart { Id = bodyPartId, Name = "Lombar", SortOrder = 0, CreatedAt = DateTimeOffset.UtcNow });
        db.ProblemTypes.Add(new ProblemType { Id = problemTypeId, BodyPartId = bodyPartId, Name = "Hérnia", SortOrder = 0, CreatedAt = DateTimeOffset.UtcNow });
        db.HealthApportments.Add(new HealthApportment
        {
            Id = Guid.NewGuid(), StudentProfileId = Guid.NewGuid(),
            BodyPartId = bodyPartId, BodyPartName = "Lombar",
            ProblemTypeId = problemTypeId, ProblemTypeName = "Hérnia",
            CreatedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        (await new DeleteProblemTypeCommandHandler(db).Handle(new DeleteProblemTypeCommand(problemTypeId), CancellationToken.None))
            .Error.Code.ShouldBe("ProblemType.InUse");
        (await new DeleteBodyPartCommandHandler(db).Handle(new DeleteBodyPartCommand(bodyPartId), CancellationToken.None))
            .Error.Code.ShouldBe("BodyPart.InUse");
    }

    [Fact]
    public async Task Update_renames_bodyPart_and_problemType_and_notFound()
    {
        await using var db = TestHarness.NewContext();
        var bp = await new CreateBodyPartCommandHandler(db).Handle(new CreateBodyPartCommand("Ombro"), CancellationToken.None);
        var pt = await new CreateProblemTypeCommandHandler(db)
            .Handle(new CreateProblemTypeCommand(bp.Value, "Deslocamento"), CancellationToken.None);

        (await new UpdateBodyPartCommandHandler(db).Handle(new UpdateBodyPartCommand(bp.Value, "Ombro D"), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();
        (await new UpdateProblemTypeCommandHandler(db).Handle(new UpdateProblemTypeCommand(pt.Value, "Luxação"), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();

        (await new UpdateBodyPartCommandHandler(db).Handle(new UpdateBodyPartCommand(Guid.NewGuid(), "X"), CancellationToken.None))
            .Error.Code.ShouldBe("BodyPart.NotFound");
        (await new UpdateProblemTypeCommandHandler(db).Handle(new UpdateProblemTypeCommand(Guid.NewGuid(), "X"), CancellationToken.None))
            .Error.Code.ShouldBe("ProblemType.NotFound");

        var list = await new ListHealthCatalogQueryHandler(db).Handle(new ListHealthCatalogQuery(), CancellationToken.None);
        list.Value.Single().Name.ShouldBe("Ombro D");
        list.Value.Single().ProblemTypes.Single().Name.ShouldBe("Luxação");
    }

    [Fact]
    public async Task Delete_succeeds_when_not_referenced_and_cascades_problem_types()
    {
        await using var db = TestHarness.NewContext();
        var bp = await new CreateBodyPartCommandHandler(db).Handle(new CreateBodyPartCommand("Punho"), CancellationToken.None);
        var pt = await new CreateProblemTypeCommandHandler(db)
            .Handle(new CreateProblemTypeCommand(bp.Value, "Tendinite"), CancellationToken.None);

        (await new DeleteProblemTypeCommandHandler(db).Handle(new DeleteProblemTypeCommand(pt.Value), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();
        (await new DeleteBodyPartCommandHandler(db).Handle(new DeleteBodyPartCommand(bp.Value), CancellationToken.None))
            .IsSuccess.ShouldBeTrue();

        var list = await new ListHealthCatalogQueryHandler(db).Handle(new ListHealthCatalogQuery(), CancellationToken.None);
        list.Value.Count.ShouldBe(0); // soft-deleted body part is filtered out
    }
}
