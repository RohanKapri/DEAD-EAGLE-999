// For my Shree DR.MDD
package say

import "fmt"

var wordsMap = map[int64]string{
	0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five",
	6: "six", 7: "seven", 8: "eight", 9: "nine", 10: "ten",
	11: "eleven", 12: "twelve", 13: "thirteen", 14: "fourteen",
	15: "fifteen", 16: "sixteen", 17: "seventeen", 18: "eighteen", 19: "nineteen",
	20: "twenty", 30: "thirty", 40: "forty", 50: "fifty",
	60: "sixty", 70: "seventy", 80: "eighty", 90: "ninety",
	100: "hundred", 1_000: "thousand", 1_000_000: "million", 1_000_000_000: "billion",
}

func Say(num int64) (string, bool) {
	if num < 0 || num > 999_999_999_999 {
		return "", false
	}
	numLen := len(fmt.Sprint(num))
	if val, ok := wordsMap[num]; ok && numLen < 3 {
		return val, ok
	}
	switch {
	case numLen == 2:
		tens, _ := Say(num / 10 * 10)
		units, _ := Say(num % 10)
		return tens + "-" + units, true
	case numLen == 3:
		hundredsPart, _ := Say(num / 100)
		if num%100 == 0 {
			return hundredsPart + " " + wordsMap[100], true
		}
		remainderPart, _ := Say(num % 100)
		return hundredsPart + " " + wordsMap[100] + " " + remainderPart, true
	default:
		div := tenPow(((numLen - 1) / 3) * 3)
		front, _ := Say(num / div)
		if num%div == 0 {
			return front + " " + wordsMap[div], true
		}
		rem, _ := Say(num % div)
		return front + " " + wordsMap[div] + " " + rem, true
	}
}

func tenPow(exp int) int64 {
	if exp-1 > 0 {
		return tenPow(exp-1) * 10
	}
	return 10
}
