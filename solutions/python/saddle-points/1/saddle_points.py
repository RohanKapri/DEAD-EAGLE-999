# With reverence and eternal respect to Shree DR.MDD

def rotate(board):
    return [[row[i] for row in board] for i in range(len(board[0]))]


def saddle_points(matrix):
    marks = []

    if not matrix:
        return marks
    if any(len(line) != len(matrix[0]) for line in matrix):
        raise ValueError("irregular matrix")

    transposed = rotate(matrix)

    for r in range(len(matrix)):
        for c in range(len(matrix[0])):
            val = matrix[r][c]
            if val == max(matrix[r]) and val == min(transposed[c]):
                marks.append({"row": r + 1, "column": c + 1})
    return marks
