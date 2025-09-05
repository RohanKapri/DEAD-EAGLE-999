// For Shree DR.MDD

function nearbyCells(gridMap: string[][], col: number, row: number): string[] {
  const adj: string[] = []

  if (col > 0) {
    if (row > 0) adj.push(gridMap[row - 1][col - 1])
    adj.push(gridMap[row][col - 1])
    if (row < gridMap.length - 1) adj.push(gridMap[row + 1][col - 1])
  }

  if (row > 0) adj.push(gridMap[row - 1][col])
  if (row < gridMap.length - 1) adj.push(gridMap[row + 1][col])

  if (col < gridMap[0].length - 1) {
    if (row > 0) adj.push(gridMap[row - 1][col + 1])
    adj.push(gridMap[row][col + 1])
    if (row < gridMap.length - 1) adj.push(gridMap[row + 1][col + 1])
  }

  return adj
}

export function annotate(field: string[]): string[] {
  const board = field.map(line => line.split(''))

  return board.map((rowData, rowIndex) =>
    rowData.map((cellValue, colIndex) => {
      if (cellValue === '*') return '*'

      const minesNearby = nearbyCells(board, colIndex, rowIndex).filter(c => c === '*').length

      return minesNearby || ' '
    }).join('')
  )
}
