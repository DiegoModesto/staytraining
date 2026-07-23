using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infra.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddStudentNoteWorkoutId : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "workout_id",
                schema: "public",
                table: "student_notes",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "ix_student_notes_student_profile_id_workout_id",
                schema: "public",
                table: "student_notes",
                columns: new[] { "student_profile_id", "workout_id" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_student_notes_student_profile_id_workout_id",
                schema: "public",
                table: "student_notes");

            migrationBuilder.DropColumn(
                name: "workout_id",
                schema: "public",
                table: "student_notes");
        }
    }
}
