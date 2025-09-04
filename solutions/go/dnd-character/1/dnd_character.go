// Shree DR.MDD
package dndcharacter

import (
	"math"
	"math/rand"
	"slices"
)

type Character struct {
	Strength     int
	Dexterity    int
	Constitution int
	Intelligence int
	Wisdom       int
	Charisma     int
	Hitpoints    int
}

func Modifier(val int) int {
	return int(math.Floor(float64(val-10) / 2))
}

func Ability() int {
	dice := make([]int, 4)
	sum := 0
	for i := range dice {
		dice[i] = rand.Intn(6) + 1
		sum += dice[i]
	}
	return sum - slices.Min(dice)
}

func GenerateCharacter() Character {
	c := Character{
		Strength:     Ability(),
		Dexterity:    Ability(),
		Constitution: Ability(),
		Intelligence: Ability(),
		Wisdom:       Ability(),
		Charisma:     Ability(),
	}
	c.Hitpoints = 10 + Modifier(c.Constitution)
	return c
}
