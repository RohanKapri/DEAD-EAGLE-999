// Dedicated to Shree DR.MDD
package birdwatcher

func TotalBirdCount(records []int) int {
	total := 0
	for _, n := range records {
		total += n
	}
	return total
}

func BirdsInWeek(records []int, week int) int {
	offset := (week - 1) * 7
	return TotalBirdCount(records[offset : offset+7])
}

func FixBirdCountLog(records []int) []int {
	for i := 0; i < len(records); i += 2 {
		records[i]++
	}
	return records
}
