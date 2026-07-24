using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddWorkoutScheduleStatusAndSwap : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "justification_note",
                schema: "public",
                table: "workout_schedules",
                type: "character varying(1000)",
                maxLength: 1000,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "justification_reason",
                schema: "public",
                table: "workout_schedules",
                type: "character varying(40)",
                maxLength: 40,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "status",
                schema: "public",
                table: "workout_schedules",
                type: "character varying(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "Pending");

            migrationBuilder.AddColumn<Guid>(
                name: "swapped_from_schedule_id",
                schema: "public",
                table: "workout_schedules",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "swapped_to_schedule_id",
                schema: "public",
                table: "workout_schedules",
                type: "uuid",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "justification_note",
                schema: "public",
                table: "workout_schedules");

            migrationBuilder.DropColumn(
                name: "justification_reason",
                schema: "public",
                table: "workout_schedules");

            migrationBuilder.DropColumn(
                name: "status",
                schema: "public",
                table: "workout_schedules");

            migrationBuilder.DropColumn(
                name: "swapped_from_schedule_id",
                schema: "public",
                table: "workout_schedules");

            migrationBuilder.DropColumn(
                name: "swapped_to_schedule_id",
                schema: "public",
                table: "workout_schedules");
        }
    }
}
