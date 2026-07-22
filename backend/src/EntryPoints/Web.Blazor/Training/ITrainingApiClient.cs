namespace Web.Blazor.Training;

/// <summary>Typed client for the StayTraining Web.API (reached through the gateway).</summary>
public interface ITrainingApiClient
{
    Task<IReadOnlyList<MuscleGroupDto>> ListMuscleGroupsAsync(CancellationToken ct);

    Task<IReadOnlyList<ExerciseListItemDto>> ListExercisesAsync(ExerciseCategory? category, CancellationToken ct);
    Task<Guid> CreateExerciseAsync(CreateExerciseRequest request, CancellationToken ct);

    Task<IReadOnlyList<WorkoutTemplateListItemDto>> ListTemplatesAsync(bool? onlySystemDefaults, CancellationToken ct);

    Task<IReadOnlyList<StudentListItemDto>> ListStudentsAsync(CancellationToken ct);
    Task<StudentDetailDto?> GetStudentAsync(Guid id, CancellationToken ct);
    Task<Guid> RegisterStudentAsync(RegisterStudentRequest request, CancellationToken ct);
    Task<Guid> AddHealthObservationAsync(Guid studentId, AddHealthObservationRequest request, CancellationToken ct);

    Task<IReadOnlyList<WorkoutListItemDto>> ListWorkoutsAsync(Guid? ownerStudentId, CancellationToken ct);
    Task<Guid> CreateWorkoutFromTemplateAsync(CreateWorkoutFromTemplateRequest request, CancellationToken ct);
}
