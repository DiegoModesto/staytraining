using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddExerciseCatalog : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "exercises",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    description = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: true),
                    category = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    primary_muscle_group_id = table.Column<Guid>(type: "uuid", nullable: false),
                    secondary_muscle_group_ids = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    usage_example = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    default_sets = table.Column<int>(type: "integer", nullable: false),
                    default_reps = table.Column<int>(type: "integer", nullable: false),
                    default_rest_seconds = table.Column<int>(type: "integer", nullable: false),
                    is_aerobic = table.Column<bool>(type: "boolean", nullable: false),
                    default_work_seconds = table.Column<int>(type: "integer", nullable: true),
                    default_interval_rest_seconds = table.Column<int>(type: "integer", nullable: true),
                    default_rounds = table.Column<int>(type: "integer", nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercises", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "muscle_groups",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    body_region = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_muscle_groups", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "exercise_media",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    kind = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    storage_key = table.Column<string>(type: "character varying(1024)", maxLength: 1024, nullable: true),
                    url = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    content_type = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true),
                    size_bytes = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise_media", x => x.id);
                    table.ForeignKey(
                        name: "fk_exercise_media_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalSchema: "public",
                        principalTable: "exercises",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_exercise_media_exercise_id",
                schema: "public",
                table: "exercise_media",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercises_tenant_id_category",
                schema: "public",
                table: "exercises",
                columns: new[] { "tenant_id", "category" });

            migrationBuilder.CreateIndex(
                name: "ix_exercises_tenant_id_id",
                schema: "public",
                table: "exercises",
                columns: new[] { "tenant_id", "id" });

            migrationBuilder.CreateIndex(
                name: "ix_muscle_groups_name",
                schema: "public",
                table: "muscle_groups",
                column: "name");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "exercise_media",
                schema: "public");

            migrationBuilder.DropTable(
                name: "muscle_groups",
                schema: "public");

            migrationBuilder.DropTable(
                name: "exercises",
                schema: "public");
        }
    }
}
