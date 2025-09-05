export function saddlePoints(matrix: number[][]): { row: number; column: number }[] {
  const points = []

  for (let row = 0; row < matrix.length; row++) {
    const rowMaximum = Math.max(...matrix[row])
    for (let column = 0; column < matrix[row].length; column++) {
      const columnMinimium = Math.min(...matrix.flatMap(row => row[column]))

      if (matrix[row][column] === columnMinimium && matrix[row][column] === rowMaximum)
        points.push({ column, row })
    }  
  }
  
  return points.map(({ column, row }) => ({ column: column + 1, row: row + 1 }))
}