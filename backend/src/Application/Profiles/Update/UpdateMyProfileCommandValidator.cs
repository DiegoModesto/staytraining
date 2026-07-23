using FluentValidation;

namespace Application.Profiles.Update;

internal sealed class UpdateMyProfileCommandValidator : AbstractValidator<UpdateMyProfileCommand>
{
    public UpdateMyProfileCommandValidator()
    {
        RuleFor(c => c.FullName).NotEmpty().MaximumLength(200);
        RuleFor(c => c.Email).NotEmpty().EmailAddress().MaximumLength(320);
        RuleFor(c => c.Phone).NotEmpty().MaximumLength(40);
        RuleFor(c => c.EmergencyPhone).MaximumLength(40);
        RuleFor(c => c.HeightCm).InclusiveBetween(30, 300).When(c => c.HeightCm.HasValue);
        RuleFor(c => c.WeightKg).InclusiveBetween(20m, 400m).When(c => c.WeightKg.HasValue);
    }
}
