namespace Web.Blazor.Training;

/// <summary>Typed client for the StayTraining Web.API (reached through the gateway).</summary>
public interface ITrainingApiClient
{
    // Current user's profile ("Meu perfil")
    Task<ProfileDto?> GetMyProfileAsync(CancellationToken ct);
    Task UpdateMyProfileAsync(UpdateProfileRequest request, CancellationToken ct);
    Task<UploadPhotoResponse> UploadMyProfilePhotoAsync(byte[] bytes, string fileName, string contentType, CancellationToken ct);

    Task<IReadOnlyList<MuscleGroupDto>> ListMuscleGroupsAsync(CancellationToken ct);
    Task<Guid> CreateMuscleGroupAsync(CreateMuscleGroupRequest request, CancellationToken ct);
    Task UpdateMuscleGroupAsync(Guid id, UpdateMuscleGroupRequest request, CancellationToken ct);
    Task DeleteMuscleGroupAsync(Guid id, CancellationToken ct);

    // Modalities (admin-managed catalog)
    Task<IReadOnlyList<ModalityDto>> ListModalitiesAsync(CancellationToken ct);
    Task<Guid> CreateModalityAsync(CreateModalityRequest request, CancellationToken ct);
    Task UpdateModalityAsync(Guid id, UpdateModalityRequest request, CancellationToken ct);
    Task DeleteModalityAsync(Guid id, CancellationToken ct);

    Task<IReadOnlyList<ExerciseListItemDto>> ListExercisesAsync(Guid? modalityId, CancellationToken ct);
    Task<Guid> CreateExerciseAsync(CreateExerciseRequest request, CancellationToken ct);

    Task<IReadOnlyList<WorkoutTemplateListItemDto>> ListTemplatesAsync(bool? onlySystemDefaults, CancellationToken ct);

    Task<IReadOnlyList<StudentListItemDto>> ListStudentsAsync(CancellationToken ct);
    Task<StudentDetailDto?> GetStudentAsync(Guid id, CancellationToken ct);
    Task<Guid> RegisterStudentAsync(RegisterStudentRequest request, CancellationToken ct);

    // Admin ficha editing (audited)
    Task UpdateStudentFichaAsync(Guid studentId, UpdateStudentFichaRequest request, CancellationToken ct);
    Task<Guid> AddStudentApportmentAsync(Guid studentId, AddApportmentRequest request, CancellationToken ct);
    Task RemoveStudentApportmentAsync(Guid studentId, Guid apportmentId, CancellationToken ct);
    Task<IReadOnlyList<StudentEditLogDto>> ListStudentEditLogsAsync(Guid studentId, CancellationToken ct);

    // Student self-service apports (own ficha)
    Task<Guid> AddMyApportmentAsync(AddApportmentRequest request, CancellationToken ct);
    Task RemoveMyApportmentAsync(Guid apportmentId, CancellationToken ct);

    // Health-issue catalog
    Task<IReadOnlyList<BodyPartDto>> ListHealthCatalogAsync(CancellationToken ct);
    Task<Guid> CreateBodyPartAsync(CatalogNameRequest request, CancellationToken ct);
    Task UpdateBodyPartAsync(Guid id, CatalogNameRequest request, CancellationToken ct);
    Task DeleteBodyPartAsync(Guid id, CancellationToken ct);
    Task<Guid> CreateProblemTypeAsync(CreateProblemTypeRequest request, CancellationToken ct);
    Task UpdateProblemTypeAsync(Guid id, CatalogNameRequest request, CancellationToken ct);
    Task DeleteProblemTypeAsync(Guid id, CancellationToken ct);

    Task<IReadOnlyList<StudentNoteDto>> ListStudentNotesAsync(Guid studentId, CancellationToken ct);
    Task<Guid> AddStudentNoteAsync(Guid studentId, AddStudentNoteRequest request, CancellationToken ct);

    Task<IReadOnlyList<WorkoutListItemDto>> ListWorkoutsAsync(Guid? ownerStudentId, CancellationToken ct);
    Task<Guid> CreateWorkoutFromTemplateAsync(CreateWorkoutFromTemplateRequest request, CancellationToken ct);
    Task DeleteWorkoutAsync(Guid workoutId, CancellationToken ct);
    Task RenameWorkoutAsync(Guid workoutId, string name, CancellationToken ct);

    // Workout building (custom / item-by-item)
    Task<Guid> CreateWorkoutAsync(CreateWorkoutRequest request, CancellationToken ct);
    Task<WorkoutDetailDto?> GetWorkoutAsync(Guid id, CancellationToken ct);
    Task<Guid> AddWorkoutItemAsync(Guid workoutId, WorkoutItemInput item, CancellationToken ct);
    Task RemoveWorkoutItemAsync(Guid workoutId, Guid itemId, CancellationToken ct);
    Task ReorderWorkoutItemsAsync(Guid workoutId, IReadOnlyList<Guid> orderedItemIds, CancellationToken ct);

    // Templates (builder)
    Task<WorkoutTemplateDetailDto?> GetTemplateAsync(Guid id, CancellationToken ct);
    Task<Guid> CreateTemplateAsync(CreateWorkoutTemplateRequest request, CancellationToken ct);

    // Execution: sessions, notes, schedule, report
    Task<Guid> StartSessionAsync(Guid workoutId, CancellationToken ct);
    Task CompleteSessionAsync(Guid sessionId, CompleteSessionRequest request, CancellationToken ct);
    Task<Guid> UpsertExerciseNoteAsync(Guid sessionId, UpsertExerciseNoteRequest request, CancellationToken ct);
    Task<IReadOnlyList<ExerciseNoteDto>> GetSessionNotesAsync(Guid sessionId, CancellationToken ct);
    Task<IReadOnlyList<WeekScheduleItemDto>> GetWeekScheduleAsync(DateOnly weekStart, Guid? studentId, CancellationToken ct);
    Task<Guid> ScheduleWorkoutAsync(ScheduleWorkoutRequest request, CancellationToken ct);
    Task DeleteScheduleAsync(Guid scheduleId, CancellationToken ct);
    Task<WeeklyReportDto?> GetWeeklyReportAsync(DateOnly weekStart, Guid? studentId, CancellationToken ct);

    // Questions (professor answers students' questions)
    Task<IReadOnlyList<QuestionDto>> ListQuestionsAsync(bool onlyOpen, CancellationToken ct);
    Task AnswerQuestionAsync(Guid id, AnswerQuestionRequest request, CancellationToken ct);
}
