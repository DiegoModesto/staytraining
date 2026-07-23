using Application.Profiles.GetMyProfile;
using Application.Profiles.SetPhoto;
using Application.Profiles.Update;
using Application.UnitTests.Support;
using Domain.Profiles;
using Domain.Students;
using Shouldly;

namespace Application.UnitTests.Profiles;

public class ProfileTests
{
    [Fact]
    public async Task GetMyProfile_maps_student_ficha_with_photo_and_apports()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        var profileId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile
        {
            Id = profileId, TenantId = tenant, UserId = userId, FullName = "Rita",
            Email = "rita@x.com", Phone = "1111", EmergencyPhone = "2222",
            BloodType = BloodType.OPositive, HeightCm = 165, WeightKg = 60.5m, PhotoKey = "avatars/x.webp",
            HealthApportments =
            [
                new HealthApportment
                {
                    Id = Guid.NewGuid(), StudentProfileId = profileId,
                    BodyPartId = Guid.NewGuid(), BodyPartName = "Ombro",
                    ProblemTypeId = Guid.NewGuid(), ProblemTypeName = "Deslocamento",
                    CreatedAt = DateTimeOffset.UtcNow,
                },
            ],
        });
        await db.SaveChangesAsync();

        var handler = new GetMyProfileQueryHandler(db, TestHarness.User(tenant, userId), new FakeFileStorage());
        var result = await handler.Handle(new GetMyProfileQuery(), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.IsStudent.ShouldBeTrue();
        result.Value.EmergencyPhone.ShouldBe("2222");
        result.Value.PhotoUrl.ShouldBe("https://files.test/avatars/x.webp");
        result.Value.Apportments.Count.ShouldBe(1);
    }

    [Fact]
    public async Task GetMyProfile_returns_shell_seeded_from_token_name_for_non_student()
    {
        var tenant = Guid.NewGuid();
        await using var db = TestHarness.NewContext();

        var handler = new GetMyProfileQueryHandler(db, TestHarness.User(tenant, Guid.NewGuid(), "Diego Modesto"), new FakeFileStorage());
        var result = await handler.Handle(new GetMyProfileQuery(), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        result.Value.IsStudent.ShouldBeFalse();
        result.Value.FullName.ShouldBe("Diego Modesto");
        result.Value.PhotoUrl.ShouldBeNull();
    }

    [Fact]
    public async Task UpdateMyProfile_updates_student_profile_in_place()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile
        {
            Id = Guid.NewGuid(), TenantId = tenant, UserId = userId, FullName = "Rita", CreatedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        var handler = new UpdateMyProfileCommandHandler(db, TestHarness.User(tenant, userId));
        var result = await handler.Handle(
            new UpdateMyProfileCommand("Rita S. Modesto", "rita@x.com", "1111", "2222", BloodType.APositive, 165, 60m),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var saved = db.StudentProfiles.Single();
        saved.FullName.ShouldBe("Rita S. Modesto");
        saved.EmergencyPhone.ShouldBe("2222");
        saved.BloodType.ShouldBe(BloodType.APositive);
        db.UserProfiles.Count().ShouldBe(0); // student path does not create a UserProfile
    }

    [Fact]
    public async Task UpdateMyProfile_upserts_user_profile_for_non_student()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();

        var handler = new UpdateMyProfileCommandHandler(db, TestHarness.User(tenant, userId));
        var result = await handler.Handle(
            new UpdateMyProfileCommand("Diego", "diego@x.com", "9999", null, BloodType.Unknown, null, null),
            CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        var profile = db.UserProfiles.Single();
        profile.UserId.ShouldBe(userId);
        profile.FullName.ShouldBe("Diego");
        profile.Email.ShouldBe("diego@x.com");
    }

    [Fact]
    public async Task SetPhoto_sets_key_on_student_profile()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        db.StudentProfiles.Add(new StudentProfile { Id = Guid.NewGuid(), TenantId = tenant, UserId = userId, FullName = "Rita", CreatedAt = DateTimeOffset.UtcNow });
        await db.SaveChangesAsync();

        var result = await new SetMyProfilePhotoCommandHandler(db, TestHarness.User(tenant, userId))
            .Handle(new SetMyProfilePhotoCommand("avatars/x.webp"), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.StudentProfiles.Single().PhotoKey.ShouldBe("avatars/x.webp");
    }

    [Fact]
    public async Task SetPhoto_creates_user_profile_for_non_student()
    {
        var tenant = Guid.NewGuid();
        var userId = Guid.NewGuid();
        await using var db = TestHarness.NewContext();

        var result = await new SetMyProfilePhotoCommandHandler(db, TestHarness.User(tenant, userId, "Diego"))
            .Handle(new SetMyProfilePhotoCommand("avatars/y.webp"), CancellationToken.None);

        result.IsSuccess.ShouldBeTrue();
        db.UserProfiles.Single().PhotoKey.ShouldBe("avatars/y.webp");
    }
}
