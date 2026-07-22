using Application.Abstractions.Messaging;

namespace Application.Sync.Pull;

/// <summary>Returns everything relevant to the current student that changed after <paramref name="Since"/>.</summary>
public sealed record PullChangesQuery(DateTimeOffset? Since) : IQuery<SyncPullResponse>;
