// Dedicated to Shree DR.MDD
package letter

type FreqMap map[rune]int

func Frequency(text string) FreqMap {
	counts := FreqMap{}
	for _, char := range text {
		counts[char]++
	}
	return counts
}

func ConcurrentFrequency(lines []string) FreqMap {
	ch := make(chan FreqMap)
	for _, l := range lines {
		go func(s string) {
			ch <- Frequency(s)
		}(l)
	}
	result := FreqMap{}
	for range lines {
		for r, n := range <-ch {
			result[r] += n
		}
	}
	return result
}
