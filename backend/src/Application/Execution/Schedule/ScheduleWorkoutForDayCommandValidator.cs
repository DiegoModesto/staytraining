using FluentValidation;

namespace Application.Execution.Schedule;

internal sealed class ScheduleWorkoutForDayCommandValidator : AbstractValidator<ScheduleWorkoutForDayCommand>
{
    public ScheduleWorkoutForDayCommandValidator()
    {
        RuleFor(c => c.WorkoutId).NotEmpty();
        RuleFor(c => c.Date).NotEqual(default(DateOnly));
    }
}
