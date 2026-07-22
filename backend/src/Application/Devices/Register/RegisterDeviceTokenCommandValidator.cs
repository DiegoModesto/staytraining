using FluentValidation;

namespace Application.Devices.Register;

internal sealed class RegisterDeviceTokenCommandValidator : AbstractValidator<RegisterDeviceTokenCommand>
{
    public RegisterDeviceTokenCommandValidator()
    {
        RuleFor(c => c.Token).NotEmpty().MaximumLength(4096);
        RuleFor(c => c.Platform).IsInEnum();
    }
}
