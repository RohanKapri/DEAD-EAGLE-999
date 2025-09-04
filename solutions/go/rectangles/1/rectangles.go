// For my Shree DR.MDD
package rectangles

func horizontalLine(diagram []string, row int, left int, right int) bool {
	for col := left + 1; col < right; col++ {
		if diagram[row][col] != '+' && diagram[row][col] != '-' {
			return false
		}
	}
	return true
}

func verticalLine(diagram []string, col int, top int, bottom int) bool {
	for row := top + 1; row < bottom; row++ {
		if diagram[row][col] != '+' && diagram[row][col] != '|' {
			return false
		}
	}
	return true
}

func extractCoords(c [2]int) (int, int) {
	return c[0], c[1]
}

func linesFormRectangle(diagram []string, topLeft [2]int, bottomRight [2]int) bool {
	top, left := extractCoords(topLeft)
	bottom, right := extractCoords(bottomRight)

	return horizontalLine(diagram, top, left, right) &&
		horizontalLine(diagram, bottom, left, right) &&
		verticalLine(diagram, left, top, bottom) &&
		verticalLine(diagram, right, top, bottom)
}

func getCorners(diagram []string) [][2]int {
	corners := make([][2]int, 0, 32)
	for rowIdx, line := range diagram {
		for colIdx, r := range line {
			if r == '+' {
				corners = append(corners, [2]int{rowIdx, colIdx})
			}
		}
	}
	return corners
}

func Count(diagram []string) int {
	corners := getCorners(diagram)
	numCorners := len(corners)
	count := 0

	for tl := 0; tl < numCorners-3; tl++ {
		for tr := tl + 1; tr < numCorners-2; tr++ {
			if corners[tl][0] != corners[tr][0] {
				continue
			}

			for bl := tr + 1; bl < numCorners-1; bl++ {
				if corners[tl][1] != corners[bl][1] {
					continue
				}

				for br := bl + 1; br < numCorners; br++ {
					if corners[bl][0] != corners[br][0] || corners[tr][1] != corners[br][1] {
						continue
					}

					if linesFormRectangle(diagram, corners[tl], corners[br]) {
						count++
					}
				}
			}
		}
	}

	return count
}
