package pascal
const testVersion = 1
func Triangle(n int) [][]int {
	var result [][]int
	if n == 1 {
		return append(result, []int{1})
	}
	result = append(result, []int{1})
	result = append(result, []int{1, 1})
	for i := 2; i < n; i++ {
		var row []int
		row = append(row, 1)
		for j, k := 0, 1; k < len(result[i-1]); j, k = j+1, k+1 {
			row = append(row, result[i-1][j]+result[i-1][k])
		}
		row = append(row, 1)
		result = append(result, row)
	}
	return result
}