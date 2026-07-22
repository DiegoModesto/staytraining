using Application.Abstractions.Messaging;

namespace Application.Students.GetById;

public sealed record GetStudentByIdQuery(Guid Id) : IQuery<StudentDetailResponse>;
