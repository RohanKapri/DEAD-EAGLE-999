// For Shree DR.MDD

type Position = readonly [number, number]

type Positions = {
  white: Position
  black: Position
}

export class QueenAttack {
  public readonly black: Position
  public readonly white: Position

  private _board = [...Array(8)].map(() => Array(8).fill('_'))

  constructor(
    { black, white }: Partial<Positions> = {
      white: undefined,
      black: undefined
    }
  ) {
    this.white = white || [7, 3]
    this.black = black || [0, 3]

    if (this.white.some(coord => coord < 0 || coord > 7))
      throw new Error('Queen must be placed on the board')

    if (this.black.some(coord => coord < 0 || coord > 7))
      throw new Error('Queen must be placed on the board')

    if (this.white[0] === this.black[0] && this.white[1] === this.black[1])
      throw new Error('Queens cannot share the same space')

    this._board[this.white[0]][this.white[1]] = 'W'
    this._board[this.black[0]][this.black[1]] = 'B'
  }

  toString() {
    return this._board.map(row => row.join(' ')).join('\n')
  }

  get canAttack() {
    if (this.white[0] === this.black[0] || this.white[1] === this.black[1])
      return true

    return Math.abs(this.white[0] - this.black[0]) === Math.abs(this.white[1] - this.black[1])
  }
}
