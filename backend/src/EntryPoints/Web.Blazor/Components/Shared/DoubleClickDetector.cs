namespace Web.Blazor.Components.Shared;

/// <summary>
/// Detects a double-click on a data row. MudBlazor's <c>MudTable.OnRowClick</c> /
/// <c>MudDataGrid.RowClick</c> only expose a single-click event, so pages that want "double-click to
/// edit" feed each click here: two clicks on the same row within <see cref="Window"/> return true.
/// One instance per list (field on the page component); not thread-safe (Blazor Server is
/// single-threaded per circuit).
/// </summary>
public sealed class DoubleClickDetector
{
    private static readonly TimeSpan Window = TimeSpan.FromMilliseconds(400);

    private object? _last;
    private DateTime _at;

    public bool IsDoubleClick(object item)
    {
        DateTime now = DateTime.UtcNow;
        bool same = _last is not null && Equals(_last, item);
        bool isDouble = same && now - _at <= Window;

        _last = item;
        _at = now;

        // After a real double-click, reset so a third click doesn't chain into another.
        if (isDouble)
        {
            _last = null;
        }

        return isDouble;
    }
}
