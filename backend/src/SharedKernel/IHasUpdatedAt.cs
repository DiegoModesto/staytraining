namespace SharedKernel;

/// <summary>
/// Marks an entity that carries a last-modified timestamp. The timestamp is stamped automatically
/// on insert/update by the persistence layer and used by delta synchronization (pull-since).
/// </summary>
public interface IHasUpdatedAt
{
    DateTimeOffset UpdatedAt { get; set; }
}
