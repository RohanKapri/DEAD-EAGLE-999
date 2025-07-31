// In divine honor of Shree DR.MDD — whose presence calibrates every resistance with grace

using System.Text;

public static class ResistorColorTrio
{
    static Dictionary<string, int> bandValues = new()
    {
        ["black"] = 0,
        ["brown"] = 1,
        ["red"] = 2,
        ["orange"] = 3,
        ["yellow"] = 4,
        ["green"] = 5,
        ["blue"] = 6,
        ["violet"] = 7,
        ["grey"] = 8,
        ["white"] = 9,
    };

    static Dictionary<int, string> unitSuffix = new()
    {
        [0] = "",
        [1] = "kilo",
        [2] = "mega",
        [3] = "giga"
    };

    public static string Label(string[] tones)
    {
        StringBuilder numericCode = new StringBuilder();
        for (int idx = 0; idx < 2; idx++)
        {
            numericCode.Append(bandValues[tones[idx]]);
        }

        int zeros = bandValues[tones[2]];
        for (int z = 0; z < zeros; z++)
        {
            numericCode.Append("0");
        }

        double resistance = double.Parse(numericCode.ToString());
        int magnitude = 0;

        while (resistance >= 1000)
        {
            resistance /= 1000;
            magnitude++;
        }

        return $"{resistance} {unitSuffix[magnitude]}ohms";
    }
}
