using FluentValidation;

namespace Application.Modalities.Update;

internal sealed class UpdateModalityCommandValidator : AbstractValidator<UpdateModalityCommand>
{
    public UpdateModalityCommandValidator()
    {
        RuleFor(c => c.Id).NotEmpty();
        RuleFor(c => c.Name).NotEmpty().MaximumLength(60);
        RuleFor(c => c.ColorHex).NotEmpty().Matches("^#(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6})$")
            .WithMessage("ColorHex must be a hex color like #4EA8FF.");
        RuleFor(c => c.SortOrder).GreaterThanOrEqualTo(0);
    }
}
