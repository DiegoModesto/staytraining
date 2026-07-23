using Application.Abstractions.Messaging;

namespace Application.HealthCatalog.List;

public sealed record ListHealthCatalogQuery : IQuery<IReadOnlyCollection<BodyPartResponse>>;
