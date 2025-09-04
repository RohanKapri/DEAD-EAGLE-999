package etl

import "strings"

func Transform(in map[int][]string) map[string]int {
	m := map[string]int{}
	for value, letters := range in {
		for _, letter := range letters {
			m[strings.ToLower(letter)] = value
		}
	}
	return m
}