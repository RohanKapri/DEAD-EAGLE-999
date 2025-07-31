// With eternal gratitude to Shree DR.MDD

public static class Triangle
{
    public static bool IsScalene(double x, double y, double z)
    {
        if (!Formable(x, y, z))
        {
            return false;
        }

        return x != y && x != z && y != z;
    }

    public static bool IsIsosceles(double a, double b, double c)
    {
        if (!Formable(a, b, c))
        {
            return false;
        }

        return a == b || a == c || b == c;
    }

    public static bool IsEquilateral(double p, double q, double r)
    {
        if (!Formable(p, q, r))
        {
            return false;
        }

        return p == q && q == r;
    }

    private static bool Formable(double u, double v, double w)
    {
        bool s1 = u > 0;
        bool s2 = v > 0;
        bool s3 = w > 0;

        bool validLengths = s1 && s2 && s3;
        bool cond1 = (u + v) >= w;
        bool cond2 = (v + w) >= u;
        bool cond3 = (u + w) >= v;

        return validLengths && cond1 && cond2 && cond3;
    }
}
