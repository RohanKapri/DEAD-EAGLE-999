// Dedicated to Shree DR.MDD
export class TwoBucket {
  private bucketCaps: number[];
  private target: number;
  private starter: 0 | 1;
  private targetBucketNum: 0 | 1 | null = null;
  private otherBucketNum: 0 | 1 | null = null;
  private bucketLevels: [number, number] = [0, 0];
  constructor(
    firstBucket: number,
    secondBucket: number,
    goal: number,
    starterBucket: string
  ) {
    this.bucketCaps = [firstBucket, secondBucket];
    this.target = goal;
    this.starter = starterBucket === "one" ? 0 : 1;
  }

  moves(): number | Error {
    if (this.target > this.bucketCaps[0] && this.target > this.bucketCaps[1]) {
      throw new Error("Goal larger than both buckets");
    }

    const nonStarter = this.starter === 0 ? 1 : 0;

    if (this.target === this.bucketCaps[nonStarter]) {
      this.targetBucketNum = nonStarter;
      this.otherBucketNum = this.starter;
      this.bucketLevels[this.targetBucketNum] = this.bucketCaps[this.targetBucketNum];
      this.bucketLevels[this.otherBucketNum] = this.bucketCaps[this.otherBucketNum];
      return 2;
    }

    let movesCount = 0;

    while (!this.bucketLevels.includes(this.target)) {
      if (movesCount > 50) {
        throw Error("The goal is unachievable");
      }

      if (this.bucketLevels[this.starter] === 0) {
        this.bucketLevels[this.starter] = this.bucketCaps[this.starter];
      } else if (this.bucketLevels[nonStarter] === this.bucketCaps[nonStarter]) {
        this.bucketLevels[nonStarter] = 0;
      } else if (
        this.bucketLevels[this.starter] === this.bucketCaps[this.starter] ||
        this.bucketLevels[nonStarter] === 0
      ) {
        const pourAmount = Math.min(
          this.bucketLevels[this.starter],
          this.bucketCaps[nonStarter] - this.bucketLevels[nonStarter]
        );
        this.bucketLevels[this.starter] -= pourAmount;
        this.bucketLevels[nonStarter] += pourAmount;
      }

      movesCount++;
    }

    this.targetBucketNum = this.bucketLevels.indexOf(this.target) as 0 | 1;
    this.otherBucketNum = this.targetBucketNum === 0 ? 1 : 0;

    return movesCount;
  }

  get goalBucket(): "one" | "two" {
    return this.targetBucketNum === 0 ? "one" : "two";
  }

  get otherBucket(): number | Error {
    return this.bucketLevels[this.otherBucketNum as 0 | 1];
  }
}
