module main

import math { max }

struct Item {
	weight int
	value  int
}

fn maximum_value(maximum_weight int, items []Item) int {
    mut dp := []int{len: maximum_weight + 1}
    for item in items {
        for w := maximum_weight; w >= item.weight; w-- {
            dp[w] = max(dp[w], dp[w - item.weight] + item.value)
        }
    }
    return dp[maximum_weight]
}