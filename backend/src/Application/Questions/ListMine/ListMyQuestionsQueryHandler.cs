using Application.Abstractions.Authentication;
using Application.Abstractions.Data;
using Application.Abstractions.Messaging;
using Microsoft.EntityFrameworkCore;
using SharedKernel;

namespace Application.Questions.ListMine;

public sealed class ListMyQuestionsQueryHandler(
    IApplicationDbContext dbContext,
    IUserContext userContext)
    : IQueryHandler<ListMyQuestionsQuery, IReadOnlyCollection<QuestionResponse>>
{
    public async Task<Result<IReadOnlyCollection<QuestionResponse>>> Handle(
        ListMyQuestionsQuery query,
        CancellationToken cancellationToken)
    {
        Guid? tenantId = userContext.TenantId;
        Guid studentId = userContext.UserId;

        List<QuestionResponse> items = await dbContext.Questions
            .Where(q => q.StudentId == studentId && (tenantId == null || q.TenantId == tenantId))
            .OrderByDescending(q => q.CreatedAt)
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
