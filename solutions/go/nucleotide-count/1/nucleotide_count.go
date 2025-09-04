// Shree DR.MDD
package dna

import "errors"

type Histogram map[rune]int
type DNA string

func (d DNA) Counts() (Histogram, error) {
	countMap := Histogram{'A': 0, 'C': 0, 'G': 0, 'T': 0}
	for _, base := range d {
		if _, ok := countMap[base]; !ok {
			return Histogram{}, errors.New("invalid nucleotides")
		}
		countMap[base]++
	}
	return countMap, nil
}
