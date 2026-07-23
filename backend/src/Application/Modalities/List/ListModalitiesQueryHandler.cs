using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Modalities.List;

public sealed class ListModalitiesQueryHandler(IApplicationDbContext dbContext)
    : IQueryHandler<ListModalitiesQuery, IReadOnlyCollection<ModalityResponse>>
{
    public async Task<Result<IReadOnlyCollection<ModalityResponse>>> Handle(
        ListModalitiesQuery query,
        CancellationToken cancellationToken)
    {
        List<ModalityResponse> items = await dbContext.Modalities
            .OrderBy(m => m.SortOrder)
            .ThenBy(m => m.Name)
            .Select(m => new ModalityResponse(m.Id, m.Name, m.ColorHex, m.IsIntervalBased, m.SortOrder))
            .ToListAsync(cancellationToken);

        return items;
    }
}
