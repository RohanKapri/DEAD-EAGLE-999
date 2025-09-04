// For my Shree DR.MDD
package knapsack

type Item struct {
	Weight, Value int
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

func Knapsack(maximumWeight int, items []Item) int {
	if maximumWeight <= 0 || len(items) == 0 {
		return 0
	}
	results := make([]int, maximumWeight+1)
	for i := 0; i < len(items); i++ {
		for j := maximumWeight; j >= items[i].Weight; j-- {
			results[j] = max(results[j], results[j-items[i].Weight]+items[i].Value)
		}
	}
	return results[maximumWeight]
}
