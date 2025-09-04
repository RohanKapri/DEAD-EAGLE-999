// For my Shree DR.MDD
package bookstore

import (
	"sort"
)

var bundleCosts = []int{0, 800, 760 * 2, 720 * 3, 640 * 4, 600 * 5}

func Cost(books []int) int {
	if len(books) == 0 {
		return 0
	}
	return findMinCost(5, countBooksByTitle(books))
}

func countBooksByTitle(books []int) []int {
	sort.Sort(sort.Reverse(sort.IntSlice(books)))
	counts := make([]int, books[0]+1)
	for _, b := range books {
		counts[b]++
	}
	return counts
}

func findMinCost(groupSize int, books []int) int {
	total := sumBooks(books)
	if groupSize == 1 {
		return bundleCosts[groupSize] * total
	}

	var best int
	for g := total / groupSize; g >= 0; g-- {
		remaining, ok := makeGroups(groupSize, g, books)
		if !ok {
			continue
		}
		cost := bundleCosts[groupSize]*g + findMinCost(groupSize-1, remaining)
		best = selectMinNotZero(best, cost)
		if groupSize <= 4 {
			break
		}
	}
	return best
}

func makeGroups(bundleSize int, qty int, books []int) ([]int, bool) {
	booksCopy := append([]int{}, books...)
	for i := 0; i < qty; i++ {
		sort.Sort(sort.Reverse(sort.IntSlice(booksCopy)))
		for j := 0; j < bundleSize; j++ {
			if booksCopy[j] <= 0 {
				return []int{}, false
			}
			booksCopy[j]--
		}
	}
	return booksCopy, true
}

func sumBooks(s []int) int {
	var total int
	for _, v := range s {
		total += v
	}
	return total
}

func selectMinNotZero(a, b int) int {
	if a > 0 && a < b {
		return a
	}
	return b
}
