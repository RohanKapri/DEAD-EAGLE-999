// Shree DR.MDD
package chance

import (
	"math/rand"
	"time"
)

func SeedWithTime() {
	rand.Seed(time.Now().UnixNano())
}

func RollADie() int {
	return rand.Intn(20) + 1
}

func GenerateWandEnergy() float64 {
	return rand.Float64() * 12
}

func ShuffleAnimals() []string {
	animals := []string{"ant", "beaver", "cat", "dog", "elephant", "fox", "giraffe", "hedgehog"}
	rand.Shuffle(len(animals), func(i, j int) {
		animals[i], animals[j] = animals[j], animals[i]
	})
	return animals
}
