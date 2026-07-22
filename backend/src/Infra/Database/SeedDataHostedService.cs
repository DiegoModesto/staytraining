using Application.Abstractions.Data;
using Domain.Exercises;
using Domain.MuscleGroups;
using Domain.Students;
using Domain.Workouts;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Infra.Database;

/// <summary>
/// Idempotent seed for reference muscle groups (global) and, when <c>Seed:TenantId</c> is configured,
/// a starter exercise catalog, system-default workout templates (musculação, funcional, boxe) and
/// mock users (aluno Rita Sibele Modesto, admin/professor Diego Modesto).
/// Runs once on startup; inserts only what is missing (matched by name).
/// </summary>
internal sealed class SeedDataHostedService(
    IServiceScopeFactory scopeFactory,
    IConfiguration configuration,
    ILogger<SeedDataHostedService> logger)
    : IHostedService
{
    /// <summary>Fixed mock user ids (use as the <c>sub</c> claim when minting dev tokens).</summary>
    public static readonly Guid AdminUserId = Guid.Parse("22222222-2222-2222-2222-222222222222");

    public static readonly Guid RitaStudentUserId = Guid.Parse("33333333-3333-3333-3333-333333333333");

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        using IServiceScope scope = scopeFactory.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<IApplicationDbContext>();

        Dictionary<string, Guid> muscleByName = await SeedMuscleGroupsAsync(db, cancellationToken);

        string? tenantRaw = configuration["Seed:TenantId"];
        if (!Guid.TryParse(tenantRaw, out Guid tenantId))
        {
            logger.LogInformation(
                "Seed: muscle groups ensured. Seed:TenantId not configured — skipping exercises/templates.");
            return;
        }

        Dictionary<string, Guid> exerciseByName =
            await SeedExercisesAsync(db, tenantId, muscleByName, cancellationToken);

        await SeedTemplatesAsync(db, tenantId, exerciseByName, cancellationToken);
        await SeedMockUsersAsync(db, tenantId, cancellationToken);

        logger.LogInformation("Seed: catalog, default templates and mock users ensured for tenant {TenantId}.", tenantId);
    }

    public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;

    /// <summary>
    /// Seeds the mock student "Rita Sibele Modesto" with a health note and a starter workout copied
    /// from the "Costas e Ombro" template. The admin/professor "Diego Modesto" needs no training-side
    /// row (identified only by <see cref="AdminUserId"/> + the Professor role).
    /// </summary>
    private async Task SeedMockUsersAsync(IApplicationDbContext db, Guid tenantId, CancellationToken ct)
    {
        StudentProfile? rita = await db.StudentProfiles
            .FirstOrDefaultAsync(s => s.TenantId == tenantId && s.UserId == RitaStudentUserId, ct);

        if (rita is null)
        {
            rita = new StudentProfile
            {
                Id = Guid.NewGuid(),
                TenantId = tenantId,
                UserId = RitaStudentUserId,
                FullName = "Rita Sibele Modesto",
                Email = "rita.modesto@example.com",
                Goals = "Ganho de força e condicionamento geral.",
                CreatedAt = DateTimeOffset.UtcNow,
            };
            rita.HealthObservations.Add(new HealthObservation
            {
                Id = Guid.NewGuid(),
                StudentProfileId = rita.Id,
                Kind = HealthObservationKind.HealthIssue,
                Title = "Cuidado com ombro direito",
                Detail = "Evitar carga máxima em desenvolvimento; progressão gradual.",
                CreatedAt = DateTimeOffset.UtcNow,
            });
            db.StudentProfiles.Add(rita);
            await db.SaveChangesAsync(ct);
        }

        bool ritaHasWorkout = await db.Workouts
            .AnyAsync(w => w.TenantId == tenantId && w.OwnerStudentId == RitaStudentUserId && !w.IsDeleted, ct);

        if (!ritaHasWorkout)
        {
            WorkoutTemplate? template = await db.WorkoutTemplates
                .Include(t => t.Items)
                .FirstOrDefaultAsync(
                    t => t.TenantId == tenantId && t.IsSystemDefault && t.Name == "Costas e Ombro", ct);

            if (template is not null)
            {
                var workout = new Workout
                {
                    Id = Guid.NewGuid(),
                    TenantId = tenantId,
                    OwnerStudentId = RitaStudentUserId,
                    SourceTemplateId = template.Id,
                    Name = template.Name,
                    Category = template.Category,
                    CreatedAt = DateTimeOffset.UtcNow,
                };
                foreach (TemplateItem item in template.Items.OrderBy(i => i.Order))
                {
                    workout.Items.Add(new WorkoutItem
                    {
                        Id = Guid.NewGuid(),
                        WorkoutId = workout.Id,
                        ExerciseId = item.ExerciseId,
                        Order = item.Order,
                        SectionLabel = item.SectionLabel,
                        Sets = item.Sets,
                        Reps = item.Reps,
                        RestSeconds = item.RestSeconds,
                        ProfessorComment = item.CreatorNotes,
                    });
                }
                db.Workouts.Add(workout);
                await db.SaveChangesAsync(ct);
            }
        }
    }

    private static async Task<Dictionary<string, Guid>> SeedMuscleGroupsAsync(
        IApplicationDbContext db, CancellationToken ct)
    {
        (string Name, string Region)[] groups =
        [
            ("Peito", "Superiores"), ("Costas", "Superiores"), ("Ombro", "Superiores"),
            ("Bíceps", "Superiores"), ("Tríceps", "Superiores"), ("Antebraço", "Superiores"),
            ("Trapézio", "Superiores"), ("Abdômen", "Core"),
            ("Quadríceps", "Inferiores"), ("Posterior de coxa", "Inferiores"),
            ("Glúteos", "Inferiores"), ("Panturrilha", "Inferiores"),
            ("Corpo inteiro", "Geral"),
        ];

        var existing = await db.MuscleGroups.Select(m => m.Name).ToListAsync(ct);
        var existingSet = existing.ToHashSet(StringComparer.OrdinalIgnoreCase);

        foreach ((string name, string region) in groups)
        {
            if (!existingSet.Contains(name))
            {
                db.MuscleGroups.Add(new MuscleGroup { Id = Guid.NewGuid(), Name = name, BodyRegion = region });
            }
        }

        await db.SaveChangesAsync(ct);

        return await db.MuscleGroups.ToDictionaryAsync(m => m.Name, m => m.Id, ct);
    }

    private static async Task<Dictionary<string, Guid>> SeedExercisesAsync(
        IApplicationDbContext db, Guid tenantId, Dictionary<string, Guid> muscle, CancellationToken ct)
    {
        // Name, Category, PrimaryMuscle, IsAerobic, sets, reps, rest, work?, intervalRest?, rounds?
        (string Name, ExerciseCategory Cat, string Muscle, bool Aer, int Sets, int Reps, int RestS,
            int? Work, int? IRest, int? Rounds)[] exercises =
        [
            ("Supino reto", ExerciseCategory.Musculacao, "Peito", false, 4, 10, 90, null, null, null),
            ("Crucifixo", ExerciseCategory.Musculacao, "Peito", false, 3, 12, 60, null, null, null),
            ("Puxada frente", ExerciseCategory.Musculacao, "Costas", false, 4, 10, 90, null, null, null),
            ("Remada curvada", ExerciseCategory.Musculacao, "Costas", false, 4, 10, 90, null, null, null),
            ("Desenvolvimento militar", ExerciseCategory.Musculacao, "Ombro", false, 4, 10, 90, null, null, null),
            ("Elevação lateral", ExerciseCategory.Musculacao, "Ombro", false, 3, 15, 45, null, null, null),
            ("Rosca direta", ExerciseCategory.Musculacao, "Bíceps", false, 3, 12, 60, null, null, null),
            ("Tríceps corda", ExerciseCategory.Musculacao, "Tríceps", false, 3, 12, 60, null, null, null),
            ("Agachamento livre", ExerciseCategory.Musculacao, "Quadríceps", false, 4, 10, 120, null, null, null),
            ("Levantamento terra", ExerciseCategory.Musculacao, "Posterior de coxa", false, 4, 8, 120, null, null, null),
            ("Prancha", ExerciseCategory.Funcional, "Abdômen", false, 3, 1, 60, null, null, null),
            ("Burpee", ExerciseCategory.Funcional, "Corpo inteiro", true, 3, 12, 45, null, null, null),
            ("Afundo", ExerciseCategory.Funcional, "Quadríceps", false, 3, 12, 60, null, null, null),
            ("Jab e direto (sombra)", ExerciseCategory.Boxe, "Corpo inteiro", true, 5, 1, 60, 120, 30, 5),
            ("Saco pesado", ExerciseCategory.Boxe, "Corpo inteiro", true, 5, 1, 60, 120, 60, 5),
            ("Polichinelo", ExerciseCategory.Aerobico, "Corpo inteiro", true, 5, 1, 30, 60, 30, 5),
            ("Pular corda", ExerciseCategory.Aerobico, "Corpo inteiro", true, 5, 1, 30, 90, 30, 5),
        ];

        var existing = await db.Exercises
            .Where(e => e.TenantId == tenantId)
            .Select(e => e.Name)
            .ToListAsync(ct);
        var existingSet = existing.ToHashSet(StringComparer.OrdinalIgnoreCase);

        foreach (var x in exercises)
        {
            if (existingSet.Contains(x.Name))
            {
                continue;
            }

            db.Exercises.Add(new Exercise
            {
                Id = Guid.NewGuid(),
                TenantId = tenantId,
                Name = x.Name,
                Category = x.Cat,
                PrimaryMuscleGroupId = muscle.TryGetValue(x.Muscle, out Guid mid) ? mid : Guid.Empty,
                IsAerobic = x.Aer,
                DefaultSets = x.Sets,
                DefaultReps = x.Reps,
                DefaultRestSeconds = x.RestS,
                DefaultWorkSeconds = x.Work,
                DefaultIntervalRestSeconds = x.IRest,
                DefaultRounds = x.Rounds,
                CreatedAt = DateTimeOffset.UtcNow,
            });
        }

        await db.SaveChangesAsync(ct);

        return await db.Exercises
            .Where(e => e.TenantId == tenantId)
            .ToDictionaryAsync(e => e.Name, e => e.Id, ct);
    }

    private static async Task SeedTemplatesAsync(
        IApplicationDbContext db, Guid tenantId, Dictionary<string, Guid> exercise, CancellationToken ct)
    {
        // Template name, category, notes, items: (exerciseName, section)
        (string Name, ExerciseCategory Cat, string Notes, (string Exercise, string Section)[] Items)[] templates =
        [
            ("Costas e Ombro", ExerciseCategory.Musculacao, "Foco em puxadas e desenvolvimento.",
            [
                ("Puxada frente", "Costas"), ("Remada curvada", "Costas"), ("Levantamento terra", "Costas"),
                ("Desenvolvimento militar", "Ombro"), ("Elevação lateral", "Ombro"),
            ]),
            ("Peito e Bíceps", ExerciseCategory.Musculacao, "Empurrar + rosca.",
            [
                ("Supino reto", "Peito"), ("Crucifixo", "Peito"), ("Rosca direta", "Bíceps"),
            ]),
            ("Funcional Full Body", ExerciseCategory.Funcional, "Circuito de corpo inteiro.",
            [
                ("Agachamento livre", "Pernas"), ("Afundo", "Pernas"),
                ("Prancha", "Core"), ("Burpee", "Cardio"),
            ]),
            ("Boxe - Iniciante", ExerciseCategory.Boxe, "Intervalado com foco técnico.",
            [
                ("Jab e direto (sombra)", "Técnica"), ("Saco pesado", "Potência"), ("Pular corda", "Condicionamento"),
            ]),
        ];

        var existing = await db.WorkoutTemplates
            .Where(t => t.TenantId == tenantId && t.IsSystemDefault)
            .Select(t => t.Name)
            .ToListAsync(ct);
        var existingSet = existing.ToHashSet(StringComparer.OrdinalIgnoreCase);

        foreach (var t in templates)
        {
            if (existingSet.Contains(t.Name))
            {
                continue;
            }

            var template = new WorkoutTemplate
            {
                Id = Guid.NewGuid(),
                TenantId = tenantId,
                Name = t.Name,
                Category = t.Cat,
                IsSystemDefault = true,
                CreatorNotes = t.Notes,
                CreatedAt = DateTimeOffset.UtcNow,
            };

            int order = 1;
            foreach ((string exName, string section) in t.Items)
            {
                if (!exercise.TryGetValue(exName, out Guid exId))
                {
                    continue;
                }

                template.Items.Add(new TemplateItem
                {
                    Id = Guid.NewGuid(),
                    WorkoutTemplateId = template.Id,
                    ExerciseId = exId,
                    Order = order++,
                    SectionLabel = section,
                    Sets = 3,
                    Reps = 12,
                    RestSeconds = 60,
                });
            }

            db.WorkoutTemplates.Add(template);
        }

        await db.SaveChangesAsync(ct);
    }
}
