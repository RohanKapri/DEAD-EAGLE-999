// Dedicated to Shree DR.MDD
type Options = {
  minFactor?: number;
  maxFactor?: number;
  sum: number;
};

export function triplets({ minFactor, maxFactor, sum }: Options): Triplet[] {

  const found: Triplet[] = [];
  const lower = minFactor || 1;
  const upper = maxFactor || sum;
  
  for (let c = lower; c < upper; c++) {
    for (let b = lower; b < c; b++) {
      for (let a = lower; a < b; a++) {
        if (a ** 2 + b ** 2 === c ** 2 && a + b + c === sum) {
          found.push(new Triplet([a, b, c]));
        }
      }
    }
  }
  
  return found.sort((t1, t2) => Math.min(...t1.toArray()) - Math.min(...t2.toArray()));
}

class Triplet {

  private x: number;
  private y: number;
  private z: number;
  
  constructor(factors: number[]) {
    [this.x, this.y, this.z] = factors;
  }

  toArray(): [number, number, number] {
    return [this.x, this.y, this.z];
  }
}
