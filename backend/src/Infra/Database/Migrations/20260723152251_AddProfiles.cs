using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddProfiles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "blood_type",
                schema: "public",
                table: "student_profiles",
                type: "character varying(20)",
                maxLength: 20,
                nullable: false,
                // Enum stored as string — existing rows must map back to a valid BloodType name.
                defaultValue: "Unknown");

            migrationBuilder.AddColumn<string>(
                name: "emergency_phone",
                schema: "public",
                table: "student_profiles",
                type: "character varying(40)",
                maxLength: 40,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "height_cm",
                schema: "public",
                table: "student_profiles",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "phone",
                schema: "public",
                table: "student_profiles",
                type: "character varying(40)",
                maxLength: 40,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "photo_key",
                schema: "public",
                table: "student_profiles",
                type: "character varying(1024)",
                maxLength: 1024,
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "weight_kg",
                schema: "public",
                table: "student_profiles",
                type: "numeric(5,2)",
                precision: 5,
                scale: 2,
                nullable: true);

            migrationBuilder.CreateTable(
                name: "user_profiles",
                schema: "public",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    tenant_id = table.Column<Guid>(type: "uuid", nullable: false),
                    updated_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    full_name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    email = table.Column<string>(type: "character varying(320)", maxLength: 320, nullable: false),
                    phone = table.Column<string>(type: "character varying(40)", maxLength: 40, nullable: true),
                    blood_type = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    height_cm = table.Column<int>(type: "integer", nullable: true),
                    weight_kg = table.Column<decimal>(type: "numeric(5,2)", precision: 5, scale: 2, nullable: true),
                    photo_key = table.Column<string>(type: "character varying(1024)", maxLength: 1024, nullable: true),
                    created_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    deleted_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    is_deleted = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user_profiles", x => x.id);
                });

            migrationBuilder.CreateIndex(
                name: "ix_user_profiles_tenant_id_user_id",
                schema: "public",
                table: "user_profiles",
                columns: new[] { "tenant_id", "user_id" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "user_profiles",
                schema: "public");

            migrationBuilder.DropColumn(
                name: "blood_type",
                schema: "public",
                table: "student_profiles");

            migrationBuilder.DropColumn(
                name: "emergency_phone",
                schema: "public",
                table: "student_profiles");

            migrationBuilder.DropColumn(
                name: "height_cm",
                schema: "public",
                table: "student_profiles");

            migrationBuilder.DropColumn(
                name: "phone",
                schema: "public",
                table: "student_profiles");

            migrationBuilder.DropColumn(
                name: "photo_key",
                schema: "public",
                table: "student_profiles");

            migrationBuilder.DropColumn(
                name: "weight_kg",
                schema: "public",
                table: "student_profiles");
        }
    }
}
