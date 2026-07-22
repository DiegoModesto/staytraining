using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddExecution : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "workout_schedules",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    student_id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: false),
                    scheduled_date = table.Column<DateOnly>(type: "date", nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_schedules", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "workout_sessions",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    student_id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: false),
                    started_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    completed_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    completion_rating = table.Column<int>(type: "integer", nullable: true),
                    overall_comment = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_sessions", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "exercise_notes",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_session_id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_item_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    load_kg = table.Column<decimal>(type: "numeric(7,2)", precision: 7, scale: 2, nullable: true),
                    pain_flag = table.Column<bool>(type: "boolean", nullable: false),
                    pain_note = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: true),
                    comment = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    performed_sets = table.Column<int>(type: "integer", nullable: true),
                    performed_reps = table.Column<int>(type: "integer", nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    updated_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise_notes", x => x.id);
                    table.ForeignKey(
                        name: "fk_exercise_notes_workout_sessions_workout_session_id",
                        column: x => x.workout_session_id,
                        principalSchema: "public",
                        principalTable: "workout_sessions",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_exercise_notes_exercise_id",
                schema: "public",
                table: "exercise_notes",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_notes_workout_session_id",
                schema: "public",
                table: "exercise_notes",
                column: "workout_session_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_notes_workout_session_id_workout_item_id",
                schema: "public",
                table: "exercise_notes",
                columns: new[] { "workout_session_id", "workout_item_id" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_workout_schedules_tenant_id_student_id_scheduled_date",
                schema: "public",
                table: "workout_schedules",
                columns: new[] { "tenant_id", "student_id", "scheduled_date" });

            migrationBuilder.CreateIndex(
                name: "ix_workout_sessions_tenant_id_student_id_workout_id_started_at",
                schema: "public",
                table: "workout_sessions",
                columns: new[] { "tenant_id", "student_id", "workout_id", "started_at" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "exercise_notes",
                schema: "public");

            migrationBuilder.DropTable(
                name: "workout_schedules",
                schema: "public");

            migrationBuilder.DropTable(
                name: "workout_sessions",
                schema: "public");
        }
    }
}
