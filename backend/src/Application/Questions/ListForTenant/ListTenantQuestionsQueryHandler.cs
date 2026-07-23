using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Questions.ListForTenant;

public sealed class ListTenantQuestionsQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListTenantQuestionsQuery, IReadOnlyCollection<QuestionResponse>>
{
    public async Task<Result<IReadOnlyCollection<QuestionResponse>>> Handle(
        ListTenantQuestionsQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;

        List<QuestionResponse> items = await dbContext.Questions
            .Where(q => tenantId == null || q.TenantId == tenantId)
            .Where(q => !query.OnlyOpen || q.AnswerText == null)
            // Unanswered first, then newest.
            .OrderBy(q => q.AnswerText != null)
            .ThenByDescending(q => q.CreatedAt)
            .Select(q => new QuestionResponse(
                q.Id,
                q.StudentId,
                q.StudentName,
                q.WorkoutId,
                q.WorkoutId == null
                    ? null
                    : dbContext.Workouts.Where(w => w.Id == q.WorkoutId).Select(w => w.Name).FirstOrDefault(),
                q.ExerciseId,
                q.ExerciseId == null
                    ? null
                    : dbContext.Exercises.Where(e => e.Id == q.ExerciseId).Select(e => e.Name).FirstOrDefault(),
                q.Text,
                q.CreatedAt,
                q.AnswerText,
                q.AnsweredByName,
                q.AnsweredAt,
                q.AnswerText != null))
            .ToListAsync(cancellationToken);

        return items;
    }
}
