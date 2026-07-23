using Application.Abstractions.Data;
using Domain.Exercises;
using Domain.HealthCatalog;
using Domain.Modalities;
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
        await SeedModalitiesAsync(db, cancellationToken);
        await SeedHealthCatalogAsync(db, cancellationToken);

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
            rita.HealthApportments.Add(new HealthApportment
            {
                Id = Guid.NewGuid(),
                StudentProfileId = rita.Id,
                BodyPartId = HealthCatalogDefaults.OmbroId,
                BodyPartName = "Ombro",
                ProblemTypeId = HealthCatalogDefaults.OmbroDeslocamentoId,
                ProblemTypeName = "Deslocamento",
                Observation = "Evitar carga máxima em desenvolvimento; progressão gradual.",
                CreatedAt = DateTimeOffset.UtcNow,
            });
            rita.Notes.Add(new StudentNote
            {
                Id = Guid.NewGuid(),
                StudentProfileId = rita.Id,
                AuthorUserId = AdminUserId,
                AuthorName = "Diego Modesto",
                Content = "Aluna dedicada e assídua. Boa evolução na técnica de agachamento.",
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
                    ModalityId = template.ModalityId,
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

    /// <summary>Ensures the built-in modalities (global reference data) exist, matched by fixed id.</summary>
    private static async Task SeedModalitiesAsync(IApplicationDbContext db, CancellationToken ct)
    {
        List<Guid> existing = await db.Modalities.Select(m => m.Id).ToListAsync(ct);
        var existingSet = existing.ToHashSet();

        foreach (ModalityDefaults.Seed seed in ModalityDefaults.All)
        {
            if (existingSet.Contains(seed.Id))
            {
                continue;
            }

            db.Modalities.Add(new Modality
            {
                Id = seed.Id,
                Name = seed.Name,
                ColorHex = seed.ColorHex,
                IsIntervalBased = seed.IsIntervalBased,
                SortOrder = seed.SortOrder,
                CreatedAt = DateTimeOffset.UtcNow,
            });
        }

        await db.SaveChangesAsync(ct);
    }

    /// <summary>Ensures the built-in health-issue catalog (body parts + problem types) exists.</summary>
    private static async Task SeedHealthCatalogAsync(IApplicationDbContext db, CancellationToken ct)
    {
        List<Guid> existingParts = await db.BodyParts.Select(b => b.Id).ToListAsync(ct);
        var partSet = existingParts.ToHashSet();
        List<Guid> existingProblems = await db.ProblemTypes.Select(p => p.Id).ToListAsync(ct);
        var problemSet = existingProblems.ToHashSet();

        foreach (HealthCatalogDefaults.BodyPartSeed part in HealthCatalogDefaults.All)
        {
            if (!partSet.Contains(part.Id))
            {
                db.BodyParts.Add(new BodyPart
                {
                    Id = part.Id,
                    Name = part.Name,
                    SortOrder = part.SortOrder,
                    CreatedAt = DateTimeOffset.UtcNow,
                });
            }

            int order = 0;
            foreach (HealthCatalogDefaults.ProblemSeed problem in part.Problems)
            {
                if (!problemSet.Contains(problem.Id))
                {
                    db.ProblemTypes.Add(new ProblemType
                    {
                        Id = problem.Id,
                        BodyPartId = part.Id,
                        Name = problem.Name,
                        SortOrder = order,
                        CreatedAt = DateTimeOffset.UtcNow,
                    });
                }

                order++;
            }
        }

        await db.SaveChangesAsync(ct);
    }

    private static async Task<Dictionary<string, Guid>> SeedExercisesAsync(
        IApplicationDbContext db, Guid tenantId, Dictionary<string, Guid> muscle, CancellationToken ct)
    {
        // Name, ModalityId, PrimaryMuscle, IsAerobic, sets, reps, rest, work?, intervalRest?, rounds?
        (string Name, Guid Mod, string Muscle, bool Aer, int Sets, int Reps, int RestS,
            int? Work, int? IRest, int? Rounds)[] exercises =
        [
            ("Supino reto", ModalityDefaults.MusculacaoId, "Peito", false, 4, 10, 90, null, null, null),
            ("Crucifixo", ModalityDefaults.MusculacaoId, "Peito", false, 3, 12, 60, null, null, null),
            ("Puxada frente", ModalityDefaults.MusculacaoId, "Costas", false, 4, 10, 90, null, null, null),
            ("Remada curvada", ModalityDefaults.MusculacaoId, "Costas", false, 4, 10, 90, null, null, null),
            ("Desenvolvimento militar", ModalityDefaults.MusculacaoId, "Ombro", false, 4, 10, 90, null, null, null),
            ("Elevação lateral", ModalityDefaults.MusculacaoId, "Ombro", false, 3, 15, 45, null, null, null),
            ("Rosca direta", ModalityDefaults.MusculacaoId, "Bíceps", false, 3, 12, 60, null, null, null),
            ("Tríceps corda", ModalityDefaults.MusculacaoId, "Tríceps", false, 3, 12, 60, null, null, null),
            ("Agachamento livre", ModalityDefaults.MusculacaoId, "Quadríceps", false, 4, 10, 120, null, null, null),
            ("Levantamento terra", ModalityDefaults.MusculacaoId, "Posterior de coxa", false, 4, 8, 120, null, null, null),
            ("Prancha", ModalityDefaults.FuncionalId, "Abdômen", false, 3, 1, 60, null, null, null),
            ("Burpee", ModalityDefaults.FuncionalId, "Corpo inteiro", true, 3, 12, 45, null, null, null),
            ("Afundo", ModalityDefaults.FuncionalId, "Quadríceps", false, 3, 12, 60, null, null, null),
            ("Jab e direto (sombra)", ModalityDefaults.BoxeId, "Corpo inteiro", true, 5, 1, 60, 120, 30, 5),
            ("Saco pesado", ModalityDefaults.BoxeId, "Corpo inteiro", true, 5, 1, 60, 120, 60, 5),
            ("Polichinelo", ModalityDefaults.AerobicoId, "Corpo inteiro", true, 5, 1, 30, 60, 30, 5),
            ("Pular corda", ModalityDefaults.AerobicoId, "Corpo inteiro", true, 5, 1, 30, 90, 30, 5),
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
                ModalityId = x.Mod,
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
        // Template name, modality, notes, items: (exerciseName, section)
        (string Name, Guid Mod, string Notes, (string Exercise, string Section)[] Items)[] templates =
        [
            ("Costas e Ombro", ModalityDefaults.MusculacaoId, "Foco em puxadas e desenvolvimento.",
            [
                ("Puxada frente", "Costas"), ("Remada curvada", "Costas"), ("Levantamento terra", "Costas"),
                ("Desenvolvimento militar", "Ombro"), ("Elevação lateral", "Ombro"),
            ]),
            ("Peito e Bíceps", ModalityDefaults.MusculacaoId, "Empurrar + rosca.",
            [
                ("Supino reto", "Peito"), ("Crucifixo", "Peito"), ("Rosca direta", "Bíceps"),
            ]),
            ("Funcional Full Body", ModalityDefaults.FuncionalId, "Circuito de corpo inteiro.",
            [
                ("Agachamento livre", "Pernas"), ("Afundo", "Pernas"),
                ("Prancha", "Core"), ("Burpee", "Cardio"),
            ]),
            ("Boxe - Iniciante", ModalityDefaults.BoxeId, "Intervalado com foco técnico.",
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
                ModalityId = t.Mod,
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
