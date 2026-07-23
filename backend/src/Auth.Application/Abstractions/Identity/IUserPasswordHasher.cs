namespace Auth.Application.Abstractions.Identity;

/// <summary>Hashes and verifies local user passwords (password grant / private deployments).</summary>
public interface IUserPasswordHasher
{
    string Hash(string password);

    bool Verify(string password, string hash);
}
