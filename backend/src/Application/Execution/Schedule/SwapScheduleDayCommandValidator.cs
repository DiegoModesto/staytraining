using FluentValidation;

namespace Application.Execution.Schedule;

internal sealed class SwapScheduleDayCommandValidator : AbstractValidator<SwapScheduleDayCommand>
{
    public SwapScheduleDayCommandValidator()
    {
        RuleFor(c => c.ScheduleId).NotEmpty();
        RuleFor(c => c.NewDate).NotEqual(default(DateOnly));
        RuleFor(c => c.Reason).MaximumLength(40);
        RuleFor(c => c.Note).MaximumLength(1000);
    }
}
