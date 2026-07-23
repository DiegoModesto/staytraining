using Application.Abstractions.Messaging;

namespace Application.Questions.Ask;

/// <summary>A student asks a question about a workout or an exercise (at least one target).</summary>
public sealed record AskQuestionCommand(Guid? WorkoutId, Guid? ExerciseId, string Text) : ICommand<Guid>;
