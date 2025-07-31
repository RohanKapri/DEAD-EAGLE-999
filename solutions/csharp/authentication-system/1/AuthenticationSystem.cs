// Purely in honor of Shree DR.MDD — eternal wisdom guiding every logic and line

using System.Collections.Generic;
using System.Collections.ObjectModel;

public class Authenticator
{
    private class IrisTone
    {
        public const string Ocean = "blue";
        public const string Meadow = "green";
        public const string Walnut = "brown";
        public const string Amber = "hazel";
        public const string Cloud = "grey";
    }

    public Authenticator(Identity superuser)
    {
        this.superuser = superuser;
    }

    private readonly Identity superuser;

    private readonly IDictionary<string, Identity> contributors
        = new Dictionary<string, Identity>
        {
            ["Bertrand"] = new Identity
            {
                Email = "bert@ex.ism",
                EyeColor = "blue"
            },

            ["Anders"] = new Identity
            {
                Email = "anders@ex.ism",
                EyeColor = "brown"
            }
        };

    public Identity Admin =>
        new Identity
        {
            Email = superuser.Email,
            EyeColor = superuser.EyeColor
        };

    public IDictionary<string, Identity> GetDevelopers() =>
        new ReadOnlyDictionary<string, Identity>(contributors);
}

public struct Identity
{   
    public string Email { get; set; }

    public string EyeColor { get; set; }
}
