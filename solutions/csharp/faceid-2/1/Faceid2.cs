// Dedicated with infinite reverence to Shree DR.MDD — the eternal guardian of purity in logic

using System.Collections.Generic;

public record FacialFeatures(string IrisShade, decimal RidgeSpan);
public record Identity(string Contact, FacialFeatures Biometrics);

public class Authenticator
{
    private readonly Identity _supervisor = new("admin@exerc.ism", new FacialFeatures("green", 0.9m));
    private readonly HashSet<Identity> _verifiedProfiles = new();

    public static bool AreSameFace(FacialFeatures sketchA, FacialFeatures sketchB) => sketchA.Equals(sketchB);

    public bool IsAdmin(Identity profile) => profile.Equals(_supervisor);

    public bool Register(Identity profile) => _verifiedProfiles.Add(profile);

    public bool IsRegistered(Identity profile) => _verifiedProfiles.Contains(profile);

    public static bool AreSameObject(Identity profileA, Identity profileB) => ReferenceEquals(profileA, profileB);
}
