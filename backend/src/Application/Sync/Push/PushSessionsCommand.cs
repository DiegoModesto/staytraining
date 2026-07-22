using Application.Abstractions.Messaging;

namespace Application.Sync.Push;

/// <summary>Uploads workout sessions (and their notes) created offline on the device.</summary>
public sealed record PushSessionsCommand(IReadOnlyCollection<SessionPushInput> Sessions)
    : ICommand<SyncPushResult>;
