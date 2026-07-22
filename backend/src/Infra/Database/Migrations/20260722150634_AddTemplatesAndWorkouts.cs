using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddTemplatesAndWorkouts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "workout_templates",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    description = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: true),
                    category = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: true),
                    is_system_default = table.Column<bool>(type: "boolean", nullable: false),
                    creator_notes = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_templates", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "workouts",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    owner_student_id = table.Column<Guid>(type: "uuid", nullable: false),
                    source_template_id = table.Column<Guid>(type: "uuid", nullable: true),
                    name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    description = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: true),
                    category = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workouts", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "template_items",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_template_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    order = table.Column<int>(type: "integer", nullable: false),
                    section_label = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    sets = table.Column<int>(type: "integer", nullable: false),
                    reps = table.Column<int>(type: "integer", nullable: false),
                    rest_seconds = table.Column<int>(type: "integer", nullable: false),
                    duration_seconds = table.Column<int>(type: "integer", nullable: true),
                    work_seconds = table.Column<int>(type: "integer", nullable: true),
                    interval_rest_seconds = table.Column<int>(type: "integer", nullable: true),
                    rounds = table.Column<int>(type: "integer", nullable: true),
                    creator_notes = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_template_items", x => x.id);
                    table.ForeignKey(
                        name: "fk_template_items_workout_templates_workout_template_id",
                        column: x => x.workout_template_id,
                        principalSchema: "public",
                        principalTable: "workout_templates",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout_items",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    order = table.Column<int>(type: "integer", nullable: false),
                    section_label = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    sets = table.Column<int>(type: "integer", nullable: false),
                    reps = table.Column<int>(type: "integer", nullable: false),
                    rest_seconds = table.Column<int>(type: "integer", nullable: false),
                    duration_seconds = table.Column<int>(type: "integer", nullable: true),
                    work_seconds = table.Column<int>(type: "integer", nullable: true),
                    interval_rest_seconds = table.Column<int>(type: "integer", nullable: true),
                    rounds = table.Column<int>(type: "integer", nullable: true),
                    professor_comment = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_items", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_items_workouts_workout_id",
                        column: x => x.workout_id,
                        principalSchema: "public",
                        principalTable: "workouts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_template_items_workout_template_id",
                schema: "public",
                table: "template_items",
                column: "workout_template_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_items_workout_id",
                schema: "public",
                table: "workout_items",
                column: "workout_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_templates_tenant_id_is_system_default",
                schema: "public",
                table: "workout_templates",
                columns: new[] { "tenant_id", "is_system_default" });

            migrationBuilder.CreateIndex(
                name: "ix_workouts_tenant_id_owner_student_id",
                schema: "public",
                table: "workouts",
                columns: new[] { "tenant_id", "owner_student_id" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "template_items",
                schema: "public");

            migrationBuilder.DropTable(
                name: "workout_items",
                schema: "public");

            migrationBuilder.DropTable(
                name: "workout_templates",
                schema: "public");

            migrationBuilder.DropTable(
                name: "workouts",
                schema: "public");
        }
    }
}
