using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.SampleEntities.GetById;
using Domain.Devices;
using Domain.Execution;
using Domain.Exercises;
using Domain.HealthCatalog;
using Domain.Modalities;
using Domain.MuscleGroups;
using Domain.Profiles;
using Domain.SampleEntities;
using Domain.Students;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using Moq;
using Shouldly;

namespace Application.UnitTests.SampleEntities;

public class GetSampleEntityByIdQueryHandlerTests
{
    private sealed class TestDbContext(DbContextOptions<TestDbContext> options)
        : DbContext(options), IApplicationDbContext
    {
        public DbSet<SampleEntity> SampleEntities => Set<SampleEntity>();
        public DbSet<UserProfile> UserProfiles => Set<UserProfile>();
        public DbSet<Modality> Modalities => Set<Modality>();
        public DbSet<MuscleGroup> MuscleGroups => Set<MuscleGroup>();
        public DbSet<Exercise> Exercises => Set<Exercise>();
        public DbSet<ExerciseMedia> ExerciseMedia => Set<ExerciseMedia>();
        public DbSet<WorkoutTemplate> WorkoutTemplates => Set<WorkoutTemplate>();
        public DbSet<TemplateItem> TemplateItems => Set<TemplateItem>();
        public DbSet<Workout> Workouts => Set<Workout>();
        public DbSet<WorkoutItem> WorkoutItems => Set<WorkoutItem>();
        public DbSet<WorkoutSchedule> WorkoutSchedules => Set<WorkoutSchedule>();
        public DbSet<WorkoutSession> WorkoutSessions => Set<WorkoutSession>();
        public DbSet<ExerciseNote> ExerciseNotes => Set<ExerciseNote>();
        public DbSet<DeviceToken> DeviceTokens => Set<DeviceToken>();
        public DbSet<StudentProfile> StudentProfiles => Set<StudentProfile>();
        public DbSet<HealthApportment> HealthApportments => Set<HealthApportment>();
        public DbSet<StudentNote> StudentNotes => Set<StudentNote>();
        public DbSet<StudentEditLog> StudentEditLogs => Set<StudentEditLog>();
        public DbSet<BodyPart> BodyParts => Set<BodyPart>();
        public DbSet<ProblemType> ProblemTypes => Set<ProblemType>();
    }

    private static TestDbContext CreateContext() =>
        new(new DbContextOptionsBuilder<TestDbContext>()
            .UseInMemoryDatabase($"sample-{Guid.NewGuid()}")
            .Options);

    private static IUserContext CreateUserContext(Guid? tenantId)
    {
        var mock = new Mock<IUserContext>();
        mock.SetupGet(u => u.TenantId).Returns(tenantId);
        return mock.Object;
    }

    [Fact]
    public async Task Handle_Should_ReturnNotFound_WhenEntityDoesNotExist()
    {
        await using var ctx = CreateContext();
        var handler = new GetSampleEntityByIdQueryHandler(ctx, CreateUserContext(Guid.NewGuid()));

        var result = await handler.Handle(
            new GetSampleEntityByIdQuery(Guid.NewGuid()),
            CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
        result.Error.Code.ShouldBe("SampleEntity.NotFound");
    }

    [Fact]
    public async Task Handle_Should_ReturnEntity_WhenFound()
    {
        Guid tenantId = Guid.NewGuid();
        await using var ctx = CreateContext();
        var entity = new SampleEntity
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            Name = "Test",
            Description = "d",
            CreatedAt = DateTimeOffset.UtcNow
        };
        ctx.SampleEntities.Add(entity);
        await ctx.SaveChangesAsync();

        var handler = new GetSampleEntityByIdQueryHandler(ctx, CreateUserContext(tenantId));
        var result = await handler.Handle(new GetSampleEntityByIdQuery(entity.Id), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.Id.ShouldBe(entity.Id);
        result.Value.Name.ShouldBe("Test");
    }

    [Fact]
    public async Task Handle_Should_ReturnNotFound_WhenEntityIsSoftDeleted()
    {
        Guid tenantId = Guid.NewGuid();
        await using var ctx = CreateContext();
        var entity = new SampleEntity
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            Name = "Test",
            CreatedAt = DateTimeOffset.UtcNow,
            IsDeleted = true,
            DeletedAt = DateTimeOffset.UtcNow
        };
        ctx.SampleEntities.Add(entity);
        await ctx.SaveChangesAsync();

        var handler = new GetSampleEntityByIdQueryHandler(ctx, CreateUserContext(tenantId));
        var result = await handler.Handle(new GetSampleEntityByIdQuery(entity.Id), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
    }

    [Fact]
    public async Task Handle_Should_ReturnNotFound_WhenEntityBelongsToAnotherTenant()
    {
        await using var ctx = CreateContext();
        var entity = new SampleEntity
        {
            Id = Guid.NewGuid(),
            TenantId = Guid.NewGuid(),
            Name = "Test",
            CreatedAt = DateTimeOffset.UtcNow
        };
        ctx.SampleEntities.Add(entity);
        await ctx.SaveChangesAsync();

        var handler = new GetSampleEntityByIdQueryHandler(ctx, CreateUserContext(Guid.NewGuid()));
        var result = await handler.Handle(new GetSampleEntityByIdQuery(entity.Id), CancellationToken.None);

        result.IsFailure.ShouldBeTrue();
    }
}
