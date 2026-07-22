using Application.Abstractions.Messaging;

namespace Application.Exercises.GetById;

public sealed record GetExerciseByIdQuery(Guid Id) : IQuery<ExerciseResponse>;
