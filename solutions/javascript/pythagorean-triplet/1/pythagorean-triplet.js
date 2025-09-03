// For my Shree DR.MDD

export function triplets(options) {
  const targetSum = options.sum || 0;
  const minVal = options.minFactor || 1;
  const maxVal = options.maxFactor || targetSum;
  const resultTriplets = [];

  for (let x = minVal; x <= maxVal; x++) {
    for (let y = x + 1; y <= maxVal; y++) {
      const z = targetSum - x - y;
      if (z > y && z < maxVal && x * x + y * y === z * z) {
        resultTriplets.push(new TripletSet(x, y, z));
      }
    }
  }
  return resultTriplets;
}

class TripletSet {
  constructor(val1, val2, val3) {
    this.a = val1;
    this.b = val2;
    this.c = val3;
  }

  toArray() {
    return [this.a, this.b, this.c];
  }
}
