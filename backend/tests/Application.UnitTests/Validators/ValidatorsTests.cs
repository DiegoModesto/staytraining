using Application.Devices.Register;
using Application.Exercises.AddMedia;
using Application.Execution.Schedule;
using Application.Execution.Sessions.Complete;
using Application.Execution.Sessions.Start;
using Application.Execution.Sessions.UpsertNote;
using Application.Modalities.Create;
using Application.Modalities.Update;
using Application.MuscleGroups.Create;
using Application.MuscleGroups.Update;
using Application.Profiles.Update;
using Application.Students.Register;
using Application.Workouts;
using Application.Workouts.Templates.Create;
using Application.Workouts.Workouts.AddItem;
using Application.Workouts.Workouts.Create;
using Application.Workouts.Workouts.CreateFromTemplate;
using Application.Workouts.Workouts.Rename;
using Domain.Devices;
using Domain.Exercises;
using Domain.Profiles;
using Domain.Students;
using Shouldly;

namespace Application.UnitTests.Validators;

public class ValidatorsTests
{
    private static WorkoutItemInput WorkoutItem() =>
        new(Guid.NewGuid(), 1, "Costas", 3, 12, 60, null, null, null, null, null);

    private static TemplateItemInput TemplateItem() =>
        new(Guid.NewGuid(), 1, "Costas", 3, 12, 60, null, null, null, null, null);

    [Fact]
    public void AddExerciseMedia_requires_key_or_url()
    {
        var v = new AddExerciseMediaCommandValidator();
        v.Validate(new AddExerciseMediaCommand(Guid.NewGuid(), ExerciseMediaKind.Gif, "k", null, null, null)).IsValid.ShouldBeTrue();
        v.Validate(new AddExerciseMediaCommand(Guid.NewGuid(), ExerciseMediaKind.Gif, null, null, null, null)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void CreateTemplate_requires_name()
    {
        var v = new CreateWorkoutTemplateCommandValidator();
        v.Validate(new CreateWorkoutTemplateCommand("T", null, null, false, null, [TemplateItem()])).IsValid.ShouldBeTrue();
        v.Validate(new CreateWorkoutTemplateCommand("", null, null, false, null, [TemplateItem()])).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void CreateWorkout_requires_name()
    {
        var v = new CreateWorkoutCommandValidator();
        v.Validate(new CreateWorkoutCommand(Guid.Empty, "W", null, null, [WorkoutItem()])).IsValid.ShouldBeTrue();
        v.Validate(new CreateWorkoutCommand(Guid.Empty, "", null, null, [WorkoutItem()])).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void CreateFromTemplate_requires_templateId()
    {
        var v = new CreateWorkoutFromTemplateCommandValidator();
        v.Validate(new CreateWorkoutFromTemplateCommand(Guid.NewGuid(), Guid.Empty, null)).IsValid.ShouldBeTrue();
        v.Validate(new CreateWorkoutFromTemplateCommand(Guid.Empty, Guid.Empty, null)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void AddWorkoutItem_requires_workout_and_exercise()
    {
        var v = new AddWorkoutItemCommandValidator();
        v.Validate(new AddWorkoutItemCommand(Guid.NewGuid(), WorkoutItem())).IsValid.ShouldBeTrue();
        v.Validate(new AddWorkoutItemCommand(Guid.Empty, WorkoutItem())).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void Schedule_requires_workout_and_date()
    {
        var v = new ScheduleWorkoutForDayCommandValidator();
        v.Validate(new ScheduleWorkoutForDayCommand(Guid.NewGuid(), new DateOnly(2026, 1, 1))).IsValid.ShouldBeTrue();
        v.Validate(new ScheduleWorkoutForDayCommand(Guid.Empty, default)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void StartSession_requires_workout()
    {
        var v = new StartSessionCommandValidator();
        v.Validate(new StartSessionCommand(Guid.NewGuid())).IsValid.ShouldBeTrue();
        v.Validate(new StartSessionCommand(Guid.Empty)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void UpsertNote_requires_ids()
    {
        var v = new UpsertExerciseNoteCommandValidator();
        v.Validate(new UpsertExerciseNoteCommand(Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid(), 10, false, null, "c", 3, 10)).IsValid.ShouldBeTrue();
        v.Validate(new UpsertExerciseNoteCommand(Guid.Empty, Guid.Empty, Guid.Empty, -1, false, null, null, null, null)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void CompleteSession_rating_range()
    {
        var v = new CompleteSessionCommandValidator();
        v.Validate(new CompleteSessionCommand(Guid.NewGuid(), 5, "ok")).IsValid.ShouldBeTrue();
        v.Validate(new CompleteSessionCommand(Guid.NewGuid(), 9, null)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void RegisterStudent_requires_user_and_name()
    {
        var v = new RegisterStudentCommandValidator();
        v.Validate(new RegisterStudentCommand(Guid.NewGuid(), "Rita", "r@x.com", null, null)).IsValid.ShouldBeTrue();
        v.Validate(new RegisterStudentCommand(Guid.Empty, "", null, null, null)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void RegisterDeviceToken_requires_token()
    {
        var v = new RegisterDeviceTokenCommandValidator();
        v.Validate(new RegisterDeviceTokenCommand("tok", DevicePlatform.Android)).IsValid.ShouldBeTrue();
        v.Validate(new RegisterDeviceTokenCommand("", DevicePlatform.Android)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void CreateModality_requires_name_and_hex_color()
    {
        var v = new CreateModalityCommandValidator();
        v.Validate(new CreateModalityCommand("Boxe", "#FF4757", true, 0)).IsValid.ShouldBeTrue();
        v.Validate(new CreateModalityCommand("", "#FF4757", true, 0)).IsValid.ShouldBeFalse();
        v.Validate(new CreateModalityCommand("Boxe", "vermelho", true, 0)).IsValid.ShouldBeFalse();
        v.Validate(new CreateModalityCommand("Boxe", "#FF4757", true, -1)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void UpdateModality_requires_id_name_and_hex_color()
    {
        var v = new UpdateModalityCommandValidator();
        v.Validate(new UpdateModalityCommand(Guid.NewGuid(), "Boxe", "#abc", true, 0)).IsValid.ShouldBeTrue();
        v.Validate(new UpdateModalityCommand(Guid.Empty, "Boxe", "#abc", true, 0)).IsValid.ShouldBeFalse();
        v.Validate(new UpdateModalityCommand(Guid.NewGuid(), "", "#abc", true, 0)).IsValid.ShouldBeFalse();
    }

    [Fact]
    public void CreateAndUpdateMuscleGroup_require_name_and_region()
    {
        new CreateMuscleGroupCommandValidator()
            .Validate(new CreateMuscleGroupCommand("Peito", "Superiores")).IsValid.ShouldBeTrue();
        new CreateMuscleGroupCommandValidator()
            .Validate(new CreateMuscleGroupCommand("", "Superiores")).IsValid.ShouldBeFalse();
        new UpdateMuscleGroupCommandValidator()
            .Validate(new UpdateMuscleGroupCommand(Guid.NewGuid(), "Peito", "")).IsValid.ShouldBeFalse();
        new UpdateMuscleGroupCommandValidator()
            .Validate(new UpdateMuscleGroupCommand(Guid.NewGuid(), "Peito", "Superiores")).IsValid.ShouldBeTrue();
    }

    [Fact]
    public void UpdateMyProfile_requires_name_email_phone()
    {
        var v = new UpdateMyProfileCommandValidator();
        v.Validate(new UpdateMyProfileCommand("Rita", "r@x.com", "1", "2", BloodType.APositive, 165, 60m)).IsValid.ShouldBeTrue();
        v.Validate(new UpdateMyProfileCommand("", "r@x.com", "1", null, BloodType.Unknown, null, null)).IsValid.ShouldBeFalse();
        v.Validate(new UpdateMyProfileCommand("Rita", "nao-email", "1", null, BloodType.Unknown, null, null)).IsValid.ShouldBeFalse();
        v.Validate(new UpdateMyProfileCommand("Rita", "r@x.com", "", null, BloodType.Unknown, null, null)).IsValid.ShouldBeFalse();
        v.Validate(new UpdateMyProfileCommand("Rita", "r@x.com", "1", null, BloodType.Unknown, 10, null)).IsValid.ShouldBeFalse(); // altura fora do range
    }

    [Fact]
    public void RenameWorkout_requires_id_and_name()
    {
        var v = new RenameWorkoutCommandValidator();
        v.Validate(new RenameWorkoutCommand(Guid.NewGuid(), "Treino A")).IsValid.ShouldBeTrue();
        v.Validate(new RenameWorkoutCommand(Guid.Empty, "Treino A")).IsValid.ShouldBeFalse();
        v.Validate(new RenameWorkoutCommand(Guid.NewGuid(), "")).IsValid.ShouldBeFalse();
    }
}
