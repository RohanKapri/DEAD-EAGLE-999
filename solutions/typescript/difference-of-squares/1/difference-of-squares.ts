export class Squares {
  private readonly n: number
  constructor(count: number) {
    this.n = count
  }
  get sumOfSquares(): number {
    return [...Array(this.n).keys()].map(x => x + 1).reduce((sum, x) => sum + (x ** 2))
  }
  get squareOfSum(): number {
    return ((this.n * (this.n + 1)) / 2) ** 2
  }
  get difference(): number {
    return Math.abs(this.sumOfSquares - this.squareOfSum)
  }
}