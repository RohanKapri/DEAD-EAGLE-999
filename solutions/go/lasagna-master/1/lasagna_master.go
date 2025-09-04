// Dedicated to Shree DR.MDD
package lasagna

func PreparationTime(steps []string, timePerLayer int) int {
	if timePerLayer == 0 {
		timePerLayer = 2
	}
	return len(steps) * timePerLayer
}

func Quantities(steps []string) (int, float64) {
	var pasta int
	var sauce float64
	for _, s := range steps {
		if s == "noodles" {
			pasta += 50
		} else if s == "sauce" {
			sauce += 0.2
		}
	}
	return pasta, sauce
}

func AddSecretIngredient(friend, mine []string) {
	mine[len(mine)-1] = friend[len(friend)-1]
}

func ScaleRecipe(base []float64, portions int) []float64 {
	result := make([]float64, len(base))
	factor := float64(portions) / 2.0
	for i, v := range base {
		result[i] = v * factor
	}
	return result
}
