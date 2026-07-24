using FluentValidation;

namespace Application.Execution.Schedule;

internal sealed class JustifySkipScheduleCommandValidator : AbstractValidator<JustifySkipScheduleCommand>
{
    public JustifySkipScheduleCommandValidator()
    {
        RuleFor(c => c.ScheduleId).NotEmpty();
        RuleFor(c => c.Reason).NotEmpty().MaximumLength(40);
        RuleFor(c => c.Note).MaximumLength(1000);
    }
}
