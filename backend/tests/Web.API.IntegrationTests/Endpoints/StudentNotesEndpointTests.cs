using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using Shouldly;
using Web.API.IntegrationTests.Infrastructure;

namespace Web.API.IntegrationTests.Endpoints;

[Collection(WebApiCollection.Name)]
public class StudentNotesEndpointTests
{
    private readonly CustomWebApplicationFactory _factory;

    public StudentNotesEndpointTests(CustomWebApplicationFactory factory) => _factory = factory;

    private HttpClient CreateClient(Guid tenantId, string subjectId, params string[] permissions)
    {
        string token = _factory.IssueTestToken(tenantId, subjectId, permissions);
        HttpClient client = _factory.CreateClient();
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return client;
    }

    private async Task<Guid> RegisterStudentAsync(HttpClient client)
    {
        HttpResponseMessage create = await client.PostAsJsonAsync(
            "/api/v1/students",
            new { userId = Guid.NewGuid(), fullName = "Rita Sibele" });
        create.StatusCode.ShouldBe(HttpStatusCode.Created);
        var body = await create.Content.ReadFromJsonAsync<IdResponse>();
        body.ShouldNotBeNull();
        return body.Id;
    }

    [Fact]
    public async Task ListNotes_Should_Return401_WhenNoToken()
    {
        HttpClient client = _factory.CreateClient();
        HttpResponseMessage response = await client.GetAsync($"/api/v1/students/{Guid.NewGuid()}/notes");
        response.StatusCode.ShouldBe(HttpStatusCode.Unauthorized);
    }

    [Fact]
    public async Task AddAndList_Notes_HappyPath()
    {
        var tenantId = Guid.NewGuid();
        HttpClient client = CreateClient(
            tenantId, Guid.NewGuid().ToString(), "student.manage", "health.write", "student.read");

        Guid studentId = await RegisterStudentAsync(client);

        HttpResponseMessage add = await client.PostAsJsonAsync(
            $"/api/v1/students/{studentId}/notes", new { content = "Aluna dedicada e assídua." });
        add.StatusCode.ShouldBe(HttpStatusCode.Created);

        HttpResponseMessage list = await client.GetAsync($"/api/v1/students/{studentId}/notes");
        list.StatusCode.ShouldBe(HttpStatusCode.OK);
        var notes = await list.Content.ReadFromJsonAsync<List<StudentNoteResponse>>();
        notes.ShouldNotBeNull();
        notes.Count.ShouldBe(1);
        notes[0].Content.ShouldBe("Aluna dedicada e assídua.");
        notes[0].AuthorName.ShouldNotBeNullOrEmpty();
    }

    [Fact]
    public async Task AddNote_Should_Return400_WhenContentEmpty()
    {
        HttpClient client = CreateClient(
            Guid.NewGuid(), Guid.NewGuid().ToString(), "student.manage", "health.write");
        Guid studentId = await RegisterStudentAsync(client);

        HttpResponseMessage add = await client.PostAsJsonAsync(
            $"/api/v1/students/{studentId}/notes", new { content = "" });
        add.StatusCode.ShouldBe(HttpStatusCode.BadRequest);
    }

    [Fact]
    public async Task AddNote_Should_Return404_WhenStudentMissing()
    {
        HttpClient client = CreateClient(Guid.NewGuid(), Guid.NewGuid().ToString(), "health.write");

        HttpResponseMessage add = await client.PostAsJsonAsync(
            $"/api/v1/students/{Guid.NewGuid()}/notes", new { content = "nota" });
        add.StatusCode.ShouldBe(HttpStatusCode.NotFound);
    }

    [Fact]
    public async Task AddNote_Should_Return403_WhenMissingWritePermission()
    {
        HttpClient client = CreateClient(Guid.NewGuid(), Guid.NewGuid().ToString(), "student.read");

        HttpResponseMessage add = await client.PostAsJsonAsync(
            $"/api/v1/students/{Guid.NewGuid()}/notes", new { content = "nota" });
        add.StatusCode.ShouldBe(HttpStatusCode.Forbidden);
    }

    [Fact]
    public async Task ListNotes_Should_Return403_ForStudentRole()
    {
        // A student token carries no "student.read" permission, so annotations stay professor-only.
        HttpClient studentClient = CreateClient(
            Guid.NewGuid(), Guid.NewGuid().ToString(), "workout.read", "report.read");

        HttpResponseMessage list = await studentClient.GetAsync($"/api/v1/students/{Guid.NewGuid()}/notes");
        list.StatusCode.ShouldBe(HttpStatusCode.Forbidden);
    }

    private sealed record IdResponse(Guid Id);

    private sealed record StudentNoteResponse(
        Guid Id, Guid AuthorUserId, string AuthorName, string Content, DateTimeOffset CreatedAt);
}
