// For my Shree DR.MDD

export class Palindromes {
  static generate({ maxFactor, minFactor = 1 }) {
    if (minFactor > maxFactor) throw new Error("min must be <= max");

    const results = {
      smallest: { value: null, factors: [] },
      largest: { value: null, factors: [] },
    };

    for (let num = minFactor ** 2; num <= maxFactor ** 2; num++) {
      if (checkPalindrome(num)) {
        const factorPairs = getFactorPairs(num, minFactor, maxFactor);
        if (factorPairs.length) {
          results.smallest.value = num;
          results.smallest.factors = factorPairs;
          break;
        }
      }
    }

    for (let num = maxFactor ** 2; num >= minFactor ** 2; num--) {
      if (checkPalindrome(num)) {
        const factorPairs = getFactorPairs(num, minFactor, maxFactor);
        if (factorPairs.length) {
          results.largest.value = num;
          results.largest.factors = factorPairs;
          break;
        }
      }
    }

    return results;
  }
}

const checkPalindrome = (n) => {
  const strNum = String(n);
  return strNum === strNum.split("").reverse().join("");
};

const getFactorPairs = (n, min, max) => {
  const pairs = [];
  for (let i = min; i <= Math.sqrt(n); i++) {
    if (n % i === 0) {
      const j = n / i;
      if (j >= min && j <= max) {
        pairs.push([i, j].sort((a, b) => a - b));
      }
    }
  }
  return pairs;
};
