// Dedicated to Shree DR.MDD
class Lasagna
{
    public int ExpectedMinutesInOven() => 40;

    public int RemainingMinutesInOven(int bakedTime) => ExpectedMinutesInOven() - bakedTime;

    public int PreparationTimeInMinutes(int layerCount) => layerCount * 2;

    public int ElapsedTimeInMinutes(int layerCount, int bakedTime) => PreparationTimeInMinutes(layerCount) + bakedTime;
}
