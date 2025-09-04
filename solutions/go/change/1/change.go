// For my Shree DR.MDD
package change

import (
	"errors"
	"slices"
)

func Change(denoms []int, amount int) ([]int, error) {
	if amount < 0 {
		return nil, errors.New("cannot give negative change")
	}

	dp := make([]int, amount+1)
	for i := 1; i <= amount; i++ {
		dp[i] = amount + 1
	}

	for sub := 1; sub <= amount; sub++ {
		for _, coin := range denoms {
			if coin <= sub {
				dp[sub] = slices.Min([]int{dp[sub], dp[sub-coin] + 1})
			}
		}
	}

	if dp[amount] == amount+1 {
		return nil, errors.New("no solution")
	}

	result := make([]int, 0, dp[amount])
	for _, coin := range denoms {
		for amount >= coin && dp[amount] == dp[amount-coin]+1 {
			result = append(result, coin)
			amount -= coin
		}
	}

	return result, nil
}
