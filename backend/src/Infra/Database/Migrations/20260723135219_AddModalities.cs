using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddModalities : Migration
    {
        /// <inheritdoc />
        // Fixed ids from Domain.Modalities.ModalityDefaults — kept literal so this migration is
        // self-contained and reproducible regardless of future code changes.
        private const string MusculacaoId = "10000000-0000-0000-0000-000000000001";
        private const string FuncionalId = "10000000-0000-0000-0000-000000000002";
        private const string BoxeId = "10000000-0000-0000-0000-000000000003";
        private const string AerobicoId = "10000000-0000-0000-0000-000000000004";

        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // 1. Create the catalog table and seed the four built-in modalities.
            migrationBuilder.CreateTable(
                name: "modalities",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    updated_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    name = table.Column<string>(type: "character varying(60)", maxLength: 60, nullable: false),
                    color_hex = table.Column<string>(type: "character varying(9)", maxLength: 9, nullable: false),
                    is_interval_based = table.Column<bool>(type: "boolean", nullable: false),
                    sort_order = table.Column<int>(type: "integer", nullable: false),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_modalities", x => x.id);
                });

            migrationBuilder.CreateIndex(
                name: "ix_modalities_name",
                schema: "public",
                table: "modalities",
                column: "name",
                unique: true);

            migrationBuilder.Sql($"""
                INSERT INTO public.modalities (id, name, color_hex, is_interval_based, sort_order, created_at, updated_at, is_deleted)
                VALUES
                    ('{MusculacaoId}', 'Musculação', '#4EA8FF', false, 0, now(), now(), false),
                    ('{FuncionalId}',  'Funcional',  '#2FD37A', false, 1, now(), now(), false),
                    ('{BoxeId}',       'Boxe',       '#FF4757', true,  2, now(), now(), false),
                    ('{AerobicoId}',   'Aeróbico',   '#FFB020', true,  3, now(), now(), false);
                """);

            // 2. Add the FK columns as nullable so existing rows can be back-filled first.
            migrationBuilder.AddColumn<Guid>(
                name: "modality_id",
                schema: "public",
                table: "workouts",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "modality_id",
                schema: "public",
                table: "workout_templates",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "modality_id",
                schema: "public",
                table: "exercises",
                type: "uuid",
                nullable: true);

            // 3. Back-fill modality_id from the legacy category string (stored as the enum name).
            foreach (string tableName in new[] { "exercises", "workouts", "workout_templates" })
            {
                migrationBuilder.Sql($"""
                    UPDATE public.{tableName} SET modality_id = CASE category
                        WHEN 'Musculacao' THEN '{MusculacaoId}'::uuid
                        WHEN 'Funcional'  THEN '{FuncionalId}'::uuid
                        WHEN 'Boxe'       THEN '{BoxeId}'::uuid
                        WHEN 'Aerobico'   THEN '{AerobicoId}'::uuid
                        ELSE NULL END;
                    """);
            }

            // Exercises require a modality — default any unexpected/legacy value to Musculação.
            migrationBuilder.Sql($"""
                UPDATE public.exercises SET modality_id = '{MusculacaoId}'::uuid WHERE modality_id IS NULL;
                """);

            // 4. Drop the legacy columns/index now that data has been migrated.
            migrationBuilder.DropIndex(
                name: "ix_exercises_tenant_id_category",
                schema: "public",
                table: "exercises");

            migrationBuilder.DropColumn(name: "category", schema: "public", table: "workouts");
            migrationBuilder.DropColumn(name: "category", schema: "public", table: "workout_templates");
            migrationBuilder.DropColumn(name: "category", schema: "public", table: "exercises");

            // 5. Exercises.modality_id is required.
            migrationBuilder.AlterColumn<Guid>(
                name: "modality_id",
                schema: "public",
                table: "exercises",
                type: "uuid",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "ix_workouts_modality_id",
                schema: "public",
                table: "workouts",
                column: "modality_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_templates_modality_id",
                schema: "public",
                table: "workout_templates",
                column: "modality_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercises_modality_id",
                schema: "public",
                table: "exercises",
                column: "modality_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercises_tenant_id_modality_id",
                schema: "public",
                table: "exercises",
                columns: new[] { "tenant_id", "modality_id" });

            migrationBuilder.AddForeignKey(
                name: "fk_exercises_modalities_modality_id",
                schema: "public",
                table: "exercises",
                column: "modality_id",
                principalSchema: "public",
                principalTable: "modalities",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_templates_modalities_modality_id",
                schema: "public",
                table: "workout_templates",
                column: "modality_id",
                principalSchema: "public",
                principalTable: "modalities",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_workouts_modalities_modality_id",
                schema: "public",
                table: "workouts",
                column: "modality_id",
                principalSchema: "public",
                principalTable: "modalities",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercises_modalities_modality_id",
                schema: "public",
                table: "exercises");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_templates_modalities_modality_id",
                schema: "public",
                table: "workout_templates");

            migrationBuilder.DropForeignKey(
                name: "fk_workouts_modalities_modality_id",
                schema: "public",
                table: "workouts");

            migrationBuilder.DropTable(
                name: "modalities",
                schema: "public");

            migrationBuilder.DropIndex(
                name: "ix_workouts_modality_id",
                schema: "public",
                table: "workouts");

            migrationBuilder.DropIndex(
                name: "ix_workout_templates_modality_id",
                schema: "public",
                table: "workout_templates");

            migrationBuilder.DropIndex(
                name: "ix_exercises_modality_id",
                schema: "public",
                table: "exercises");

            migrationBuilder.DropIndex(
                name: "ix_exercises_tenant_id_modality_id",
                schema: "public",
                table: "exercises");

            migrationBuilder.DropColumn(
                name: "modality_id",
                schema: "public",
                table: "workouts");

            migrationBuilder.DropColumn(
                name: "modality_id",
                schema: "public",
                table: "workout_templates");

            migrationBuilder.DropColumn(
                name: "modality_id",
                schema: "public",
                table: "exercises");

            migrationBuilder.AddColumn<string>(
                name: "category",
                schema: "public",
                table: "workouts",
                type: "character varying(30)",
                maxLength: 30,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "category",
                schema: "public",
                table: "workout_templates",
                type: "character varying(30)",
                maxLength: 30,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "category",
                schema: "public",
                table: "exercises",
                type: "character varying(30)",
                maxLength: 30,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "ix_exercises_tenant_id_category",
                schema: "public",
                table: "exercises",
                columns: new[] { "tenant_id", "category" });
        }
    }
}
