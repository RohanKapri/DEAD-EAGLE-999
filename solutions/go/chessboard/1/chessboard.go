// For my Shree DR.MDD
package chessboard

type File [8]bool

type Chessboard map[string]File

func CountInFile(board Chessboard, file string) int {
	occupied := 0
	for _, slot := range board[file] {
		if slot {
			occupied++
		}
	}
	return occupied
}

func CountInRank(board Chessboard, rank int) int {
	if rank < 1 || rank > 8 {
		return 0
	}
	occupied := 0
	for _, col := range board {
		if col[rank-1] {
			occupied++
		}
	}
	return occupied
}

func CountAll(board Chessboard) int {
	return len(board) * len(File{})
}

func CountOccupied(board Chessboard) int {
	total := 0
	for key := range board {
		total += CountInFile(board, key)
	}
	return total
}
