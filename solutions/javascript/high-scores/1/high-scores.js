export class HighScores {
  constructor(scores) {
    this._scores = scores;  
  }

  get scores() {
    return this._scores;
  }

  get latest() {
    return this._scores[this._scores.length - 1];
  }

  get personalBest() {
    return Math.max(...this._scores);
  }

  get personalTopThree() {
    const sortedScores = [...this._scores].sort((a, b) => b - a);
    return sortedScores.slice(0, 3);
  }
}