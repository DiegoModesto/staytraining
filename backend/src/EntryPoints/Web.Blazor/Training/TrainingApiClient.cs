using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Claims;
using Microsoft.AspNetCore.Components.Authorization;
using Web.Blazor.Authentication.TokenStore;

namespace Web.Blazor.Training;

/// <summary>
/// Calls the StayTraining Web.API through the gateway, forwarding the signed-in user's access token.
/// Uses <see cref="AuthenticationStateProvider"/> (not <c>IHttpContextAccessor</c>) to obtain the
/// principal so it works both under static SSR and inside an interactive Server circuit — the latter
/// has no <c>HttpContext</c>, which is why the workout editor and execution player need this path.
/// </summary>
internal sealed class TrainingApiClient(
    HttpClient httpClient,
    AuthenticationStateProvider authStateProvider,
    ITokenStore tokenStore) : ITrainingApiClient
{
    private const string Base = "/api/v1";

    public Task<IReadOnlyList<MuscleGroupDto>> ListMuscleGroupsAsync(CancellationToken ct)
        => GetListAsync<MuscleGroupDto>($"{Base}/muscle-groups", ct);

    public async Task<Guid> CreateMuscleGroupAsync(CreateMuscleGroupRequest request, CancellationToken ct)
        => (await PostAsync<CreateMuscleGroupRequest, IdResponse>($"{Base}/muscle-groups", request, ct)).Id;

    public Task UpdateMuscleGroupAsync(Guid id, UpdateMuscleGroupRequest request, CancellationToken ct)
        => SendWithBodyAsync(HttpMethod.Put, $"{Base}/muscle-groups/{id}", request, ct);

    public Task DeleteMuscleGroupAsync(Guid id, CancellationToken ct)
        => SendNoBodyAsync(HttpMethod.Delete, $"{Base}/muscle-groups/{id}", ct);

    public Task<IReadOnlyList<ModalityDto>> ListModalitiesAsync(CancellationToken ct)
        => GetListAsync<ModalityDto>($"{Base}/modalities", ct);

    public async Task<Guid> CreateModalityAsync(CreateModalityRequest request, CancellationToken ct)
        => (await PostAsync<CreateModalityRequest, IdResponse>($"{Base}/modalities", request, ct)).Id;

    public Task UpdateModalityAsync(Guid id, UpdateModalityRequest request, CancellationToken ct)
        => SendWithBodyAsync(HttpMethod.Put, $"{Base}/modalities/{id}", request, ct);

    public Task DeleteModalityAsync(Guid id, CancellationToken ct)
        => SendNoBodyAsync(HttpMethod.Delete, $"{Base}/modalities/{id}", ct);

    public Task<IReadOnlyList<ExerciseListItemDto>> ListExercisesAsync(Guid? modalityId, CancellationToken ct)
    {
        string path = $"{Base}/exercises";
        if (modalityId is not null)
        {
            path += $"?modalityId={modalityId}";
        }

        return GetListAsync<ExerciseListItemDto>(path, ct);
    }

    public async Task<Guid> CreateExerciseAsync(CreateExerciseRequest request, CancellationToken ct)
        => (await PostAsync<CreateExerciseRequest, IdResponse>($"{Base}/exercises", request, ct)).Id;

    public Task<IReadOnlyList<WorkoutTemplateListItemDto>> ListTemplatesAsync(bool? onlySystemDefaults, CancellationToken ct)
    {
        string path = $"{Base}/workout-templates";
        if (onlySystemDefaults is not null)
        {
            path += $"?onlySystemDefaults={onlySystemDefaults.Value.ToString().ToLowerInvariant()}";
        }

        return GetListAsync<WorkoutTemplateListItemDto>(path, ct);
    }

    public Task<IReadOnlyList<StudentListItemDto>> ListStudentsAsync(CancellationToken ct)
        => GetListAsync<StudentListItemDto>($"{Base}/students", ct);

    public Task<StudentDetailDto?> GetStudentAsync(Guid id, CancellationToken ct)
        => GetOrNullAsync<StudentDetailDto>($"{Base}/students/{id}", ct);

    public async Task<Guid> RegisterStudentAsync(RegisterStudentRequest request, CancellationToken ct)
        => (await PostAsync<RegisterStudentRequest, IdResponse>($"{Base}/students", request, ct)).Id;

    public async Task<Guid> AddHealthObservationAsync(Guid studentId, AddHealthObservationRequest request, CancellationToken ct)
        => (await PostAsync<AddHealthObservationRequest, IdResponse>($"{Base}/students/{studentId}/health", request, ct)).Id;

    public Task<IReadOnlyList<StudentNoteDto>> ListStudentNotesAsync(Guid studentId, CancellationToken ct)
        => GetListAsync<StudentNoteDto>($"{Base}/students/{studentId}/notes", ct);

    public async Task<Guid> AddStudentNoteAsync(Guid studentId, AddStudentNoteRequest request, CancellationToken ct)
        => (await PostAsync<AddStudentNoteRequest, IdResponse>($"{Base}/students/{studentId}/notes", request, ct)).Id;

    public Task<IReadOnlyList<WorkoutListItemDto>> ListWorkoutsAsync(Guid? ownerStudentId, CancellationToken ct)
    {
        string path = $"{Base}/workouts";
        if (ownerStudentId is not null)
        {
            path += $"?ownerStudentId={ownerStudentId}";
        }

        return GetListAsync<WorkoutListItemDto>(path, ct);
    }

    public async Task<Guid> CreateWorkoutFromTemplateAsync(CreateWorkoutFromTemplateRequest request, CancellationToken ct)
        => (await PostAsync<CreateWorkoutFromTemplateRequest, IdResponse>($"{Base}/workouts/from-template", request, ct)).Id;

    public Task DeleteWorkoutAsync(Guid workoutId, CancellationToken ct)
        => SendNoBodyAsync(HttpMethod.Delete, $"{Base}/workouts/{workoutId}", ct);

    public Task RenameWorkoutAsync(Guid workoutId, string name, CancellationToken ct)
        => SendWithBodyAsync(HttpMethod.Put, $"{Base}/workouts/{workoutId}/name", new RenameWorkoutRequest(name), ct);

    // ----- workout building -----

    public async Task<Guid> CreateWorkoutAsync(CreateWorkoutRequest request, CancellationToken ct)
        => (await PostAsync<CreateWorkoutRequest, IdResponse>($"{Base}/workouts", request, ct)).Id;

    public Task<WorkoutDetailDto?> GetWorkoutAsync(Guid id, CancellationToken ct)
        => GetOrNullAsync<WorkoutDetailDto>($"{Base}/workouts/{id}", ct);

    public async Task<Guid> AddWorkoutItemAsync(Guid workoutId, WorkoutItemInput item, CancellationToken ct)
        => (await PostAsync<WorkoutItemInput, IdResponse>($"{Base}/workouts/{workoutId}/items", item, ct)).Id;

    public Task RemoveWorkoutItemAsync(Guid workoutId, Guid itemId, CancellationToken ct)
        => SendNoBodyAsync(HttpMethod.Delete, $"{Base}/workouts/{workoutId}/items/{itemId}", ct);

    public Task ReorderWorkoutItemsAsync(Guid workoutId, IReadOnlyList<Guid> orderedItemIds, CancellationToken ct)
        => SendWithBodyAsync(HttpMethod.Put, $"{Base}/workouts/{workoutId}/items/order",
            new ReorderWorkoutItemsRequest(orderedItemIds), ct);

    // ----- templates -----

    public Task<WorkoutTemplateDetailDto?> GetTemplateAsync(Guid id, CancellationToken ct)
        => GetOrNullAsync<WorkoutTemplateDetailDto>($"{Base}/workout-templates/{id}", ct);

    public async Task<Guid> CreateTemplateAsync(CreateWorkoutTemplateRequest request, CancellationToken ct)
        => (await PostAsync<CreateWorkoutTemplateRequest, IdResponse>($"{Base}/workout-templates", request, ct)).Id;

    // ----- execution -----

    public async Task<Guid> StartSessionAsync(Guid workoutId, CancellationToken ct)
        => (await PostAsync<StartSessionBody, IdResponse>($"{Base}/sessions", new StartSessionBody(workoutId), ct)).Id;

    public Task CompleteSessionAsync(Guid sessionId, CompleteSessionRequest request, CancellationToken ct)
        => SendWithBodyAsync(HttpMethod.Post, $"{Base}/sessions/{sessionId}/complete", request, ct);

    public async Task<Guid> UpsertExerciseNoteAsync(Guid sessionId, UpsertExerciseNoteRequest request, CancellationToken ct)
        => (await PostAsync<UpsertExerciseNoteRequest, IdResponse>(
            $"{Base}/sessions/{sessionId}/notes", request, ct, HttpMethod.Put)).Id;

    public Task<IReadOnlyList<ExerciseNoteDto>> GetSessionNotesAsync(Guid sessionId, CancellationToken ct)
        => GetListAsync<ExerciseNoteDto>($"{Base}/sessions/{sessionId}/notes", ct);

    public Task<IReadOnlyList<WeekScheduleItemDto>> GetWeekScheduleAsync(DateOnly weekStart, Guid? studentId, CancellationToken ct)
    {
        string path = $"{Base}/schedule/week?weekStart={weekStart:yyyy-MM-dd}";
        if (studentId is not null)
        {
            path += $"&studentId={studentId}";
        }

        return GetListAsync<WeekScheduleItemDto>(path, ct);
    }

    public async Task<Guid> ScheduleWorkoutAsync(ScheduleWorkoutRequest request, CancellationToken ct)
        => (await PostAsync<ScheduleWorkoutRequest, IdResponse>($"{Base}/schedule", request, ct)).Id;

    public Task<WeeklyReportDto?> GetWeeklyReportAsync(DateOnly weekStart, Guid? studentId, CancellationToken ct)
    {
        string path = $"{Base}/reports/weekly?weekStart={weekStart:yyyy-MM-dd}";
        if (studentId is not null)
        {
            path += $"&studentId={studentId}";
        }

        return GetOrNullAsync<WeeklyReportDto>(path, ct);
    }

    private sealed record StartSessionBody(Guid WorkoutId);

    // ----- helpers (token-forwarding) -----

    private async Task AuthorizeAsync(HttpRequestMessage request, CancellationToken ct)
    {
        AuthenticationState state = await authStateProvider.GetAuthenticationStateAsync();
        string? sessionId = state.User.FindFirstValue("session_id")
            ?? throw new UnauthorizedAccessException("No session id on principal.");

        SessionTokens tokens = await tokenStore.GetAsync(sessionId, ct)
            ?? throw new UnauthorizedAccessException("No tokens for session.");

        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", tokens.AccessToken);
    }

    private async Task<IReadOnlyList<T>> GetListAsync<T>(string path, CancellationToken ct)
    {
        using var req = new HttpRequestMessage(HttpMethod.Get, path);
        await AuthorizeAsync(req, ct);
        using HttpResponseMessage resp = await httpClient.SendAsync(req, ct);
        resp.EnsureSuccessStatusCode();
        return await resp.Content.ReadFromJsonAsync<List<T>>(ct) ?? [];
    }

    private async Task<T?> GetOrNullAsync<T>(string path, CancellationToken ct)
        where T : class
    {
        using var req = new HttpRequestMessage(HttpMethod.Get, path);
        await AuthorizeAsync(req, ct);
        using HttpResponseMessage resp = await httpClient.SendAsync(req, ct);
        if (resp.StatusCode == HttpStatusCode.NotFound)
        {
            return null;
        }

        resp.EnsureSuccessStatusCode();
        return await resp.Content.ReadFromJsonAsync<T>(ct);
    }

    private async Task<TResp> PostAsync<TBody, TResp>(
        string path, TBody body, CancellationToken ct, HttpMethod? method = null)
    {
        using var req = new HttpRequestMessage(method ?? HttpMethod.Post, path) { Content = JsonContent.Create(body) };
        await AuthorizeAsync(req, ct);
        using HttpResponseMessage resp = await httpClient.SendAsync(req, ct);
        resp.EnsureSuccessStatusCode();
        return await resp.Content.ReadFromJsonAsync<TResp>(ct)
            ?? throw new InvalidOperationException("Empty response from API.");
    }

    private async Task SendWithBodyAsync<TBody>(HttpMethod method, string path, TBody body, CancellationToken ct)
    {
        using var req = new HttpRequestMessage(method, path) { Content = JsonContent.Create(body) };
        await AuthorizeAsync(req, ct);
        using HttpResponseMessage resp = await httpClient.SendAsync(req, ct);
        resp.EnsureSuccessStatusCode();
    }

    private async Task SendNoBodyAsync(HttpMethod method, string path, CancellationToken ct)
    {
        using var req = new HttpRequestMessage(method, path);
        await AuthorizeAsync(req, ct);
        using HttpResponseMessage resp = await httpClient.SendAsync(req, ct);
        resp.EnsureSuccessStatusCode();
    }
}
