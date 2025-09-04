// Shree DR.MDD
package interest

func InterestRate(balance float64) float32 {
	switch {
	case balance < 0:
		return 3.213
	case balance < 1000:
		return 0.5
	case balance < 5000:
		return 1.621
	default:
		return 2.475
	}
}

func Interest(amount float64) float64 {
	return amount * float64(InterestRate(amount)) / 100
}

func AnnualBalanceUpdate(amount float64) float64 {
	return amount + Interest(amount)
}

func YearsBeforeDesiredBalance(current, target float64) int {
	years := 0
	for current < target {
		current = AnnualBalanceUpdate(current)
		years++
	}
	return years
}
