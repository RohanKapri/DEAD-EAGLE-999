public static class EliudsEggs
{
    public static int EggCount(int encodedCount)
    {
        int count = 0;
        for (int i=0; i<32; i++) {
            if (((encodedCount >> i) & 1) == 1) count++;
        }
        return count;
    }
}