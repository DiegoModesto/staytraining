using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using Web.Blazor.Authentication.TokenStore;

namespace Web.Blazor.Training;

/// <summary>
/// Calls the StayTraining Web.API through the gateway, forwarding the signed-in user's access token
/// (same pattern as <c>AdminGatewayClient</c>).
/// </summary>
internal sealed class TrainingApiClient(
    HttpClient httpClient,
    IHttpContextAccessor httpContextAccessor,
    ITokenStore tokenStore) : ITrainingApiClient
{
    private const string Base = "/api/v1";

    public Task<IReadOnlyList<MuscleGroupDto>> ListMuscleGroupsAsync(CancellationToken ct)
        => GetListAsync<MuscleGroupDto>($"{Base}/muscle-groups", ct);

    public Task<IReadOnlyList<ExerciseListItemDto>> ListExercisesAsync(ExerciseCategory? category, CancellationToken ct)
    {
        string path = $"{Base}/exercises";
        if (category is not null)
        {
            path += $"?category={(int)category}";
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

    // ----- helpers (token-forwarding) -----

    private async Task AuthorizeAsync(HttpRequestMessage request, CancellationToken ct)
    {
        string? sessionId = httpContextAccessor.HttpContext?.User.FindFirstValue("session_id")
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

    private async Task<TResp> PostAsync<TBody, TResp>(string path, TBody body, CancellationToken ct)
    {
        using var req = new HttpRequestMessage(HttpMethod.Post, path) { Content = JsonContent.Create(body) };
        await AuthorizeAsync(req, ct);
        using HttpResponseMessage resp = await httpClient.SendAsync(req, ct);
        resp.EnsureSuccessStatusCode();
        return await resp.Content.ReadFromJsonAsync<TResp>(ct)
            ?? throw new InvalidOperationException("Empty response from API.");
    }
}
