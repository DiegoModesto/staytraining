using Application.Abstractions.Messaging;

namespace Application.Profiles.SetPhoto;

/// <summary>Persists the storage key of an already-uploaded profile photo onto the current user's profile.</summary>
public sealed record SetMyProfilePhotoCommand(string PhotoKey) : ICommand;
