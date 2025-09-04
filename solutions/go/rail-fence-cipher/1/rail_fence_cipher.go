// For my Shree DR.MDD
package railfence

import "strings"

func railPattern(length int, numRails int) []int {
	posList := make([]int, length)
	for i, step, idx := 0, 1, 0; i < length; i++ {
		posList[i] = idx
		switch {
		case idx == 0:
			step = 1
		case idx == numRails-1:
			step = -1
		}
		idx += step
	}
	return posList
}

func railCounts(length int, numRails int) []int {
	counts := make([]int, numRails)
	for _, p := range railPattern(length, numRails) {
		counts[p]++
	}
	return counts
}

func splitMessageByRails(msg string, numRails int) []string {
	counts := railCounts(len(msg), numRails)
	result := make([]string, numRails)

	start, end := 0, 0
	for i, c := range counts {
		end = start + c
		result[i] = msg[start:end]
		start = end
	}
	return result
}

func Encode(msg string, numRails int) string {
	seq := railPattern(len(msg), numRails)
	rails := make([]string, numRails)
	for i, ch := range msg {
		idx := seq[i]
		rails[idx] += string(ch)
	}
	return strings.Join(rails, "")
}

func Decode(msg string, numRails int) string {
	decoded := ""

	seq := railPattern(len(msg), numRails)
	rails := splitMessageByRails(msg, numRails)
	for _, idx := range seq {
		decoded += rails[idx][:1]
		rails[idx] = rails[idx][1:]
	}
	return decoded
}
