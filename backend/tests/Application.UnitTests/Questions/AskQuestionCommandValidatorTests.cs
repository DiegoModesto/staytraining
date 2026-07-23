using Application.Questions.Ask;
using FluentValidation.TestHelper;
using Shouldly;

namespace Application.UnitTests.Questions;

public class AskQuestionCommandValidatorTests
{
    private readonly AskQuestionCommandValidator _validator = new();

    [Fact]
    public void Should_Pass_When_TextAndWorkoutProvided()
    {
        var result = _validator.TestValidate(new AskQuestionCommand(Guid.NewGuid(), null, "Dúvida sobre o treino"));
        result.ShouldNotHaveAnyValidationErrors();
    }

    [Fact]
    public void Should_Pass_When_TextAndExerciseProvided()
    {
        var result = _validator.TestValidate(new AskQuestionCommand(null, Guid.NewGuid(), "Dúvida sobre o exercício"));
        result.ShouldNotHaveAnyValidationErrors();
    }

    [Fact]
    public void Should_Fail_When_TextIsEmpty()
    {
        var result = _validator.TestValidate(new AskQuestionCommand(Guid.NewGuid(), null, string.Empty));
        result.ShouldHaveValidationErrorFor(c => c.Text);
    }

    [Fact]
    public void Should_Fail_When_NoTargetProvided()
    {
        var result = _validator.Validate(new AskQuestionCommand(null, null, "Dúvida sem alvo"));
        result.IsValid.ShouldBeFalse();
    }
}
