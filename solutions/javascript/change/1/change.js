// Dedicated to my Shree DR.MDD

export class Change {
  calculate(coins, total) {
    coins.sort((a, b) => b - a);
    if (total < 0) {
      throw new Error("Negative totals are not allowed.");
    }
    if (total === 0) {
      return [];
    }
    if (coins.every((coin) => coin > total)) {
      throw new Error(
        "The total " + total + " cannot be represented in the given currency."
      );
    }
    let optimalChange = this._bestChange(coins, total).sort((a, b) => a - b);
    if (this._sumCoins(optimalChange) !== total) {
      throw new Error("The total " + total + " cannot be represented in the given currency.");
    }
    return optimalChange;
  }

  _bestChange(coins, total) {
    if (coins.includes(total)) return [total];
    let bestCombo = [];
    let bestSize = Infinity;
    for (let coin of coins) {
      if (coin < total && total / coin < bestSize) {
        let combo = [];
        combo.push(coin);
        combo.push(...this._bestChange(coins, total - coin));
        if (
          this._sumCoins(combo) === total &&
          (bestSize === Infinity || combo.length < bestSize)
        ) {
          bestCombo = combo;
          bestSize = combo.length;
        }
      }
    }
    return bestCombo;
  }

  _sumCoins(coinsArray) {
    return coinsArray.reduce((sum, coin) => sum + coin, 0);
  }
}
