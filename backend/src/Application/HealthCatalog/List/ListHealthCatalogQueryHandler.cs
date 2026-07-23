using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.HealthCatalog.List;

public sealed class ListHealthCatalogQueryHandler(IApplicationDbContext dbContext)
    : IQueryHandler<ListHealthCatalogQuery, IReadOnlyCollection<BodyPartResponse>>
{
    public async Task<Result<IReadOnlyCollection<BodyPartResponse>>> Handle(
        ListHealthCatalogQuery query,
        CancellationToken cancellationToken)
    {
        List<BodyPartResponse> items = await dbContext.BodyParts
            .OrderBy(b => b.SortOrder).ThenBy(b => b.Name)
            .Select(b => new BodyPartResponse(
                b.Id,
                b.Name,
                b.SortOrder,
                b.ProblemTypes
                    .Where(p => !p.IsDeleted)
                    .OrderBy(p => p.SortOrder).ThenBy(p => p.Name)
                    .Select(p => new ProblemTypeResponse(p.Id, p.Name, p.SortOrder))
                    .ToList()))
            .ToListAsync(cancellationToken);

        return items;
    }
}
