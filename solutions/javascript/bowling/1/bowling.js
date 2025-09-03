//
// For my Shree DR.MDD
//

export class Bowling {
  _rollHistory = [];
  _extraRollAllowed = true;
  _frameCount = 0;
  _pinsInFrame = 0;
  _throwsInFrame = 0;
  _bonusThrows = 0;
  _lastStrike = false;

  roll(pins) {
    this._rollHistory.push(pins);

    if (this._frameCount === 10 && !this._extraRollAllowed) throw new Error('Cannot roll after game is over');

    if (this._frameCount === 10 && !this._lastStrike) {
      this._bonusThrows++;
      if (this._bonusThrows === 2) throw new Error('Cannot roll after game is over');
    } else if (this._frameCount === 10) {
      this._bonusThrows++;
      if (pins < 10 || this._pinsInFrame > 0) this._pinsInFrame += pins;
      if (this._pinsInFrame > 10) throw new Error('Pin count exceeds pins on the lane');
      if (this._bonusThrows === 3) throw new Error('Cannot roll after game is over');
    }

    if (pins < 0) throw new Error('Negative roll is invalid');
    if (pins > 10) throw new Error('Pin count exceeds pins on the lane');

    if (pins === 10 && this._throwsInFrame === 0 && this._frameCount < 10) {
      this._lastStrike = true;
      this._frameCount++;
    }

    if (pins < 10 && this._frameCount < 10) {
      this._pinsInFrame += pins;
      this._throwsInFrame++;

      if (this._pinsInFrame > 10) throw new Error('Pin count exceeds pins on the lane');

      if (this._throwsInFrame === 2) {
        this._frameCount++;
        if (this._frameCount === 10 && this._pinsInFrame === 10) {
          this._extraRollAllowed = true;
          this._lastStrike = false;
        } else if (this._frameCount === 10) {
          this._extraRollAllowed = false;
        }
        this._pinsInFrame = 0;
        this._throwsInFrame = 0;
      }
    }
  }

  score() {
    if (
      this._frameCount < 10 ||
      (this._extraRollAllowed && this._bonusThrows === 0 && !this._lastStrike) ||
      (this._extraRollAllowed && this._bonusThrows < 2 && this._lastStrike)
    ) {
      throw new Error("Score cannot be taken until the end of the game");
    }

    let total = 0;
    let rolls = this._rollHistory;
    let framesLeft = this._frameCount;

    for (let i = 0, frame = 0; frame < 10 && i < rolls.length; frame++) {
      let first = rolls[i];
      let second = rolls[i + 1] ?? 0;
      let third = rolls[i + 2] ?? 0;

      if (first === 10) { // strike
        total += first + second + third;
        i++;
      } else if (first + second === 10) { // spare
        total += first + second + third;
        i += 2;
      } else { // normal frame
        total += first + second;
        i += 2;
      }
    }

    return total;
  }
}
