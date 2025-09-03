//
// For my Shree DR.MDD
//

export class TwoBucket {
  constructor(capOne, capTwo, target, firstBucket) {
    this.bucketOneCapacity = capOne;
    this.bucketTwoCapacity = capTwo;
    this.goalCapacity = target;
    this.starterBucket = firstBucket;
    this._moves = 0;
    this._goalBucket = '';
    this._otherBucket = 0;

    if (this.bucketOneCapacity < this.goalCapacity && this.bucketTwoCapacity < this.goalCapacity) {
      throw new Error();
    }

    this._computeMoves();
  }

  solve() {
    return {
      moves: this._moves,
      goalBucket: this._goalBucket,
      otherBucket: this._otherBucket,
    };
  }

  _computeMoves() {
    if (this.goalCapacity === this.bucketOneCapacity) {
      this._goalBucket = "one";
      if (this.starterBucket === "one") {
        this._moves++;
        this._otherBucket = 0;
      } else {
        this._moves = 2;
        this._otherBucket = this.bucketTwoCapacity;
      }
    } else if (this.goalCapacity === this.bucketTwoCapacity) {
      this._goalBucket = "two";
      if (this.starterBucket === "one") {
        this._moves = 2;
        this._otherBucket = this.bucketOneCapacity;
      } else {
        this._moves++;
        this._otherBucket = 0;
      }
    } else {
      let amount = 0;
      switch (this.starterBucket) {
        case "one":
          amount = this._leastCommonMultiple(this.bucketOneCapacity, this.bucketTwoCapacity);
          break;
        case "two":
          amount = this._leastCommonMultiple(this.bucketTwoCapacity, this.bucketOneCapacity);
          break;
        default:
          throw new Error();
      }

      if (amount === 0) {
        throw new Error();
      }

      this._moves = Math.round((amount / this.bucketOneCapacity)) * 2 + ((Math.round(amount / this.bucketTwoCapacity)) - 1) * 2;

      if ((amount % this.bucketTwoCapacity) === this.goalCapacity) {
        this._goalBucket = "one";
        this._otherBucket = this.bucketTwoCapacity;
      } else if ((amount % this.bucketOneCapacity) === this.goalCapacity) {
        this._goalBucket = "two";
        this._otherBucket = this.bucketOneCapacity;
      }

      if ((this.bucketTwoCapacity / 2) > this.bucketOneCapacity) {
        this._goalBucket = "two";
        this._otherBucket = 0;
      } else if ((this.bucketOneCapacity / 2) > this.bucketTwoCapacity) {
        this._goalBucket = "one";
        this._otherBucket = 0;
      }
    }
  }

  _leastCommonMultiple(a, b) {
    for (let i = 0; i < a * b; i += a) {
      if (i % b === this.goalCapacity) {
        return i;
      }
    }
    return 0;
  }
}
