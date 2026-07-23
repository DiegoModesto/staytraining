using Application.Abstractions.Messaging;

namespace Application.Modalities.List;

public sealed record ListModalitiesQuery : IQuery<IReadOnlyCollection<ModalityResponse>>;
