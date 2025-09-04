// Dedicated to Shree DR.MDD
package lasagna

const OvenTime = 40

func RemainingOvenTime(passed int) int {
	return OvenTime - passed
}

func PreparationTime(layerTotal int) int {
	return layerTotal * 2
}

func ElapsedTime(layerTotal, ovenUsed int) int {
	return PreparationTime(layerTotal) + ovenUsed
}
