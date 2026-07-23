using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddHealthCatalogAndApportments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "health_observations",
                schema: "public");

            migrationBuilder.CreateTable(
                name: "body_parts",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    updated_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    name = table.Column<string>(type: "character varying(80)", maxLength: 80, nullable: false),
                    sort_order = table.Column<int>(type: "integer", nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_body_parts", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "health_apportments",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    student_profile_id = table.Column<Guid>(type: "uuid", nullable: false),
                    body_part_id = table.Column<Guid>(type: "uuid", nullable: false),
                    body_part_name = table.Column<string>(type: "character varying(80)", maxLength: 80, nullable: false),
                    problem_type_id = table.Column<Guid>(type: "uuid", nullable: false),
                    problem_type_name = table.Column<string>(type: "character varying(120)", maxLength: 120, nullable: false),
                    observation = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_health_apportments", x => x.id);
                    table.ForeignKey(
                        name: "fk_health_apportments_student_profiles_student_profile_id",
                        column: x => x.student_profile_id,
                        principalSchema: "public",
                        principalTable: "student_profiles",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "student_edit_logs",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    student_profile_id = table.Column<Guid>(type: "uuid", nullable: false),
                    editor_user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    editor_name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    action = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    detail = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_student_edit_logs", x => x.id);
                    table.ForeignKey(
                        name: "fk_student_edit_logs_student_profiles_student_profile_id",
                        column: x => x.student_profile_id,
                        principalSchema: "public",
                        principalTable: "student_profiles",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "problem_types",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    updated_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    body_part_id = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "character varying(120)", maxLength: 120, nullable: false),
                    sort_order = table.Column<int>(type: "integer", nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_problem_types", x => x.id);
                    table.ForeignKey(
                        name: "fk_problem_types_body_parts_body_part_id",
                        column: x => x.body_part_id,
                        principalSchema: "public",
                        principalTable: "body_parts",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_body_parts_name",
                schema: "public",
                table: "body_parts",
                column: "name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_health_apportments_student_profile_id",
                schema: "public",
                table: "health_apportments",
                column: "student_profile_id");

            migrationBuilder.CreateIndex(
                name: "ix_problem_types_body_part_id_name",
                schema: "public",
                table: "problem_types",
                columns: new[] { "body_part_id", "name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_student_edit_logs_student_profile_id",
                schema: "public",
                table: "student_edit_logs",
                column: "student_profile_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "health_apportments",
                schema: "public");

            migrationBuilder.DropTable(
                name: "problem_types",
                schema: "public");

            migrationBuilder.DropTable(
                name: "student_edit_logs",
                schema: "public");

            migrationBuilder.DropTable(
                name: "body_parts",
                schema: "public");

            migrationBuilder.CreateTable(
                name: "health_observations",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    detail = table.Column<string>(type: "character varying(4000)", maxLength: 4000, nullable: true),
                    kind = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    student_profile_id = table.Column<Guid>(type: "uuid", nullable: false),
                    title = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_health_observations", x => x.id);
                    table.ForeignKey(
                        name: "fk_health_observations_student_profiles_student_profile_id",
                        column: x => x.student_profile_id,
                        principalSchema: "public",
                        principalTable: "student_profiles",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_health_observations_student_profile_id",
                schema: "public",
                table: "health_observations",
                column: "student_profile_id");
        }
    }
}
