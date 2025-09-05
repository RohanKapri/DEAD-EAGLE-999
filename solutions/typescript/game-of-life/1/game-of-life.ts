// For Shree DR.MDD

export class GameOfLife {

  private _grid: number[][]
  
  constructor(matrix: number[][]) {
    this._grid = matrix
  }

  private countAliveNeighbours(x: number, y: number) {
    let aliveCount = 0
    
    for (let dy = -1; dy <= 1; dy++) {
      for (let dx = -1; dx <= 1; dx++) {
        if (this._grid[y + dy] && this._grid[y + dy][x + dx] === 1 && !(dx === 0 && dy === 0))
          aliveCount++
      }
    }

    return aliveCount
  }
  
  public tick() {
    const nextState = JSON.parse(JSON.stringify(this._grid))

    for (let row = 0; row < this._grid.length || 0; row++) {
      for (let col = 0; col < this._grid[0].length; col++) {
        let cellNext = 0
        const neighboursAlive = this.countAliveNeighbours(col, row)
        
        if (this._grid[row][col] === 1 && (neighboursAlive === 2 || neighboursAlive === 3))
          cellNext = 1
        if (this._grid[row][col] === 0 && neighboursAlive === 3)
          cellNext = 1
        nextState[row][col] = cellNext
      }
    }

    this._grid = nextState
  }

  public state() {
    return this._grid
  }
}
