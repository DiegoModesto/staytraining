using Application.Devices.Register;
using Application.UnitTests.Support;
using Domain.Devices;
using Shouldly;

namespace Application.UnitTests.Devices;

public class DeviceTests
{
    [Fact]
    public async Task Register_inserts_then_upserts_same_token()
    {
        var tenant = Guid.NewGuid();
        var me = Guid.NewGuid();
        await using var db = TestHarness.NewContext();
        var handler = new RegisterDeviceTokenCommandHandler(db, TestHarness.User(tenant, me));

        var first = await handler.Handle(new RegisterDeviceTokenCommand("tok-1", DevicePlatform.Android), CancellationToken.None);
        first.IsSuccess.ShouldBeTrue();

        var second = await handler.Handle(new RegisterDeviceTokenCommand("tok-1", DevicePlatform.Ios), CancellationToken.None);
        second.IsSuccess.ShouldBeTrue();

        db.DeviceTokens.Count().ShouldBe(1);
        db.DeviceTokens.Single().Platform.ShouldBe(DevicePlatform.Ios);
        second.Value.ShouldBe(first.Value);
    }
}
