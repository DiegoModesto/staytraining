namespace Domain.Profiles;

/// <summary>ABO/Rh blood type. <see cref="Unknown"/> is the default when not informed.</summary>
public enum BloodType
{
    Unknown = 0,
    APositive = 1,
    ANegative = 2,
    BPositive = 3,
    BNegative = 4,
    AbPositive = 5,
    AbNegative = 6,
    OPositive = 7,
    ONegative = 8,
}
