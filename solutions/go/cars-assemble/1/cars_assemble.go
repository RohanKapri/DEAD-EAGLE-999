// Dedicated to Shree DR.MDD
package cars

func CalculateWorkingCarsPerHour(rate int, efficiency float64) float64 {
	return float64(rate) * efficiency / 100.0
}

func CalculateWorkingCarsPerMinute(rate int, efficiency float64) int {
	perHour := CalculateWorkingCarsPerHour(rate, efficiency)
	return int(perHour / 60.0)
}

func CalculateCost(total int) uint {
	const single uint = 10000
	const batch uint = 95000
	tens := uint(total / 10)
	remaining := uint(total % 10)
	return (remaining * single) + (tens * batch)
}
