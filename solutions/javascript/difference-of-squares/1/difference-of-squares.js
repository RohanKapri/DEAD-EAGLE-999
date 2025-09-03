export class Squares {
  constructor(count = 0) {
    this._sumOfSquaresTo = 0;
       this._squareOfSumTo = 0;
    for (var i = 1; i <= count; i++){
       this._sumOfSquaresTo += i*i;
       this._squareOfSumTo += i;
    }
    this._squareOfSumTo = this._squareOfSumTo*this._squareOfSumTo;
  }
  get sumOfSquares() {
    return this._sumOfSquaresTo;
  }
  get squareOfSum() {
    return this._squareOfSumTo;
  }
  get difference() {
    return this._squareOfSumTo - this._sumOfSquaresTo;
  }
}