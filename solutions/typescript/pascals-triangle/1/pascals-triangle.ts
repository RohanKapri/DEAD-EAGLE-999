export class Triangle {

  private _rows = [[1]]
  
  constructor(maxDepth: number) {
    for (let depth = 1; depth < maxDepth; depth++) {
      this._rows.push([])

      for (let i = 0; i < this._rows[depth - 1].length + 1; i++)
        this._rows[depth].push((this._rows[depth - 1][i - 1] || 0) + (this._rows[depth - 1][i] || 0))
    }
  }

  get rows() {
    return this._rows
  }

  get lastRow() {
    return this._rows[this._rows.length - 1]
  }
}