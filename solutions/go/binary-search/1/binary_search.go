package binarysearch
func SearchInts(list []int, target int) int {
	for left, right := 0, len(list)-1; left <= right; {
		middle := (left + right) / 2
		switch {
		case list[middle] < target:
			left = middle + 1
		case list[middle] > target:
			right = middle - 1
		case list[middle] == target:
			return middle
		}
	}
	return -1
}