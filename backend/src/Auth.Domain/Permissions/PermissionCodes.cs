namespace Auth.Domain.Permissions;

public static class PermissionCodes
{
    public const string UsersRead = "users.read";
    public const string UsersWrite = "users.write";
    public const string GroupsRead = "groups.read";
    public const string GroupsWrite = "groups.write";
    public const string RolesRead = "roles.read";
    public const string RolesWrite = "roles.write";
    public const string M2MClientsRead = "m2mclients.read";
    public const string M2MClientsWrite = "m2mclients.write";
    public const string AuditRead = "audit.read";
    public const string SampleRead = "sample.read";
    public const string SampleWrite = "sample.write";

    // StayTraining domain permissions
    public const string ModalityRead = "modality.read";
    public const string ModalityWrite = "modality.write";
    public const string MuscleWrite = "muscle.write";
    public const string HealthCatalogRead = "healthcatalog.read";
    public const string HealthCatalogWrite = "healthcatalog.write";
    public const string ExerciseRead = "exercise.read";
    public const string ExerciseWrite = "exercise.write";
    public const string TemplateRead = "template.read";
    public const string TemplateWrite = "template.write";
    public const string WorkoutRead = "workout.read";
    public const string WorkoutWrite = "workout.write";
    public const string StudentRead = "student.read";
    public const string StudentManage = "student.manage";
    public const string HealthRead = "health.read";
    public const string HealthWrite = "health.write";
    public const string StudentFichaWrite = "studentficha.write";
    public const string SessionWrite = "session.write";
    public const string NoteWrite = "note.write";
    public const string ReportRead = "report.read";
    public const string QuestionAsk = "question.ask";
    public const string QuestionAnswer = "question.answer";

    public static IReadOnlyCollection<(string Code, string Description)> All { get; } =
    [
        (UsersRead, "Read users"),
        (UsersWrite, "Create and modify users"),
        (GroupsRead, "Read groups"),
        (GroupsWrite, "Create and modify groups"),
        (RolesRead, "Read roles"),
        (RolesWrite, "Create and modify roles"),
        (M2MClientsRead, "Read machine-to-machine clients"),
        (M2MClientsWrite, "Create and modify machine-to-machine clients"),
        (AuditRead, "Read audit events"),
        (SampleRead, "Read sample entities"),
        (SampleWrite, "Create and modify sample entities"),
        (ModalityRead, "Read training modalities"),
        (ModalityWrite, "Create, modify and delete training modalities (admin)"),
        (MuscleWrite, "Create, modify and delete muscle groups (admin)"),
        (HealthCatalogRead, "Read the health-issue catalog (body parts / problem types)"),
        (HealthCatalogWrite, "Manage the health-issue catalog (admin)"),
        (ExerciseRead, "Read exercises"),
        (ExerciseWrite, "Create and modify exercises"),
        (TemplateRead, "Read workout templates"),
        (TemplateWrite, "Create and modify workout templates"),
        (WorkoutRead, "Read workouts"),
        (WorkoutWrite, "Create and modify workouts"),
        (StudentRead, "Read students"),
        (StudentManage, "Register and manage students"),
        (HealthRead, "Read student health observations"),
        (HealthWrite, "Create and modify student health observations"),
        (StudentFichaWrite, "Edit any student's ficha as an administrator (audited)"),
        (SessionWrite, "Start and complete workout sessions"),
        (NoteWrite, "Create exercise notes"),
        (ReportRead, "Read training reports"),
        (QuestionAsk, "Ask the professor a question about a workout or exercise"),
        (QuestionAnswer, "Answer students' questions"),
    ];

    /// <summary>Permissions granted to the Aluno (student) role.</summary>
    public static IReadOnlyCollection<string> StudentRole { get; } =
    [
        ModalityRead, HealthCatalogRead, ExerciseRead, TemplateRead, WorkoutRead, SessionWrite, NoteWrite, ReportRead,
        QuestionAsk,
    ];

    /// <summary>Permissions granted to the Professor (teacher) role — superset of the student's.</summary>
    public static IReadOnlyCollection<string> TeacherRole { get; } =
    [
        ModalityRead, HealthCatalogRead, ExerciseRead, ExerciseWrite, TemplateRead, TemplateWrite,
        WorkoutRead, WorkoutWrite, StudentRead, StudentManage, HealthRead, HealthWrite,
        SessionWrite, NoteWrite, ReportRead, QuestionAnswer,
    ];

    /// <summary>
    /// Administrator capabilities layered on top of a base role — the "Configurações" area: managing
    /// the internal catalogs (modalities, muscle groups, health-issue catalog). Kept out of
    /// <see cref="TeacherRole"/> so a plain professor can read/pick these but not manage them.
    /// </summary>
    public static IReadOnlyCollection<string> Admin { get; } =
    [
        ModalityRead, ModalityWrite, MuscleWrite, HealthCatalogRead, HealthCatalogWrite, StudentFichaWrite,
    ];
}
