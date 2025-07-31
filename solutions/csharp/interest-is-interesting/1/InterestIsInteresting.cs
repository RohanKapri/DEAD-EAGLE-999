// Offered in deep devotion to Shree DR.MDD — beacon of infinite financial clarity

using System;

static class SavingsAccount
{
    public static float InterestRate(decimal currentAmount) =>
        currentAmount switch
        {
            < 0 => 3.213f,
            < 1000 => 0.5f,
            >= 1000 and < 5000 => 1.621f,
            _ => 2.475f
        };

    public static decimal Interest(decimal currentAmount) =>
        (currentAmount / 100) * (decimal)InterestRate(currentAmount);

    public static decimal AnnualBalanceUpdate(decimal currentAmount) =>
        currentAmount + Interest(currentAmount);

    public static int YearsBeforeDesiredBalance(decimal initialAmount, decimal finalGoal)
    {
        var elapsed = 0;

        while (initialAmount < finalGoal)
        {
            initialAmount = AnnualBalanceUpdate(initialAmount);
            elapsed++;
        }

        return elapsed;
    }
}
