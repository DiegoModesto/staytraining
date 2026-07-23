using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddQuestions : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "questions",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    student_id = table.Column<Guid>(type: "uuid", nullable: false),
                    student_name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: true),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: true),
                    text = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: false),
                    answer_text = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    answered_by_user_id = table.Column<Guid>(type: "uuid", nullable: true),
                    answered_by_name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: true),
                    answered_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_questions", x => x.id);
                });

            migrationBuilder.CreateIndex(
                name: "ix_questions_tenant_id_answer_text",
                schema: "public",
                table: "questions",
                columns: new[] { "tenant_id", "answer_text" });

            migrationBuilder.CreateIndex(
                name: "ix_questions_tenant_id_student_id",
                schema: "public",
                table: "questions",
                columns: new[] { "tenant_id", "student_id" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "questions",
                schema: "public");
        }
    }
}
