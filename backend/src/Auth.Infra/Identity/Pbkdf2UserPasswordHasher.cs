using System.Security.Cryptography;
using Auth.Application.Abstractions.Identity;

namespace Auth.Infra.Identity;

/// <summary>PBKDF2 (SHA-512) password hasher for local user logins. Same construction as the client
/// secret hasher, kept separate so the two concerns can evolve independently.</summary>
internal sealed class Pbkdf2UserPasswordHasher : IUserPasswordHasher
{
    private const int SaltSize = 16;
    private const int HashSize = 32;
    private const int Iterations = 100_000;

    private static readonly HashAlgorithmName Algorithm = HashAlgorithmName.SHA512;

    public string Hash(string password)
    {
        byte[] salt = RandomNumberGenerator.GetBytes(SaltSize);
        byte[] hash = Rfc2898DeriveBytes.Pbkdf2(password, salt, Iterations, Algorithm, HashSize);

        return $"{Convert.ToHexString(hash)}-{Convert.ToHexString(salt)}";
    }

    public bool Verify(string password, string hash)
    {
        string[] parts = hash.Split('-');
        if (parts.Length != 2)
        {
            return false;
        }

        byte[] storedHash = Convert.FromHexString(parts[0]);
        byte[] salt = Convert.FromHexString(parts[1]);

        byte[] inputHash = Rfc2898DeriveBytes.Pbkdf2(password, salt, Iterations, Algorithm, HashSize);
        return CryptographicOperations.FixedTimeEquals(storedHash, inputHash);
    }
}
