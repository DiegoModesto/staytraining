using Application.Abstractions.Messaging;

namespace Application.Students.List;

public sealed record ListStudentsQuery : IQuery<IReadOnlyCollection<StudentListItemResponse>>;
