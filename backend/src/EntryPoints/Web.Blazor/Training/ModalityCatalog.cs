namespace Web.Blazor.Training;

/// <summary>
/// Circuit-scoped cache of the modality catalog so pages/dialogs can resolve a modality (label +
/// color) by id without each one re-fetching. Call <see cref="Invalidate"/> after an admin edit so
/// the next read reloads. Registered as Scoped (per Blazor Server circuit).
/// </summary>
internal sealed class ModalityCatalog(ITrainingApiClient api)
{
    private IReadOnlyList<ModalityDto>? _all;
    private Dictionary<Guid, ModalityDto>? _byId;

    public async Task<IReadOnlyList<ModalityDto>> AllAsync(CancellationToken ct)
    {
        if (_all is null)
        {
            _all = await api.ListModalitiesAsync(ct);
            _byId = _all.ToDictionary(m => m.Id);
        }

        return _all;
    }

    public async Task<ModalityDto?> GetAsync(Guid? id, CancellationToken ct)
    {
        if (id is null)
        {
            return null;
        }

        await AllAsync(ct);
        return _byId!.GetValueOrDefault(id.Value);
    }

    public void Invalidate()
    {
        _all = null;
        _byId = null;
    }
}
