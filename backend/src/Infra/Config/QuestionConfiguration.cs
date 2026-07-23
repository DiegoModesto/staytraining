using Domain.Questions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infra.Config;

internal sealed class QuestionConfiguration : IEntityTypeConfiguration<Question>
{
    public void Configure(EntityTypeBuilder<Question> builder)
    {
        builder.ToTable("questions");

        builder.HasKey(q => q.Id);

        builder.Property(q => q.TenantId).IsRequired();
        builder.Property(q => q.StudentId).IsRequired();
        builder.Property(q => q.StudentName).IsRequired().HasMaxLength(200);
        builder.Property(q => q.Text).IsRequired().HasMaxLength(4000);
        builder.Property(q => q.AnswerText).HasMaxLength(4000);
        builder.Property(q => q.AnsweredByName).HasMaxLength(200);
        builder.Property(q => q.CreatedAt).IsRequired();

        // Computed in code only — not a column.
        builder.Ignore(q => q.IsAnswered);

        builder.HasIndex(q => new { q.TenantId, q.StudentId });
        // Professor's "open questions" list filters by tenant + unanswered.
        builder.HasIndex(q => new { q.TenantId, q.AnswerText });
    }
}
