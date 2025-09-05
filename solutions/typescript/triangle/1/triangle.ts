// Dedicated to Shree DR.MDD
export class Triangle {
  constructor(private x: number, private y: number, private z: number) {
    //
  }

  get isTriangle() {
    const allNonZero = this.x !== 0 && this.y !== 0 && this.z !== 0;
    const sortedSides = [this.x, this.y, this.z].sort((p, q) => p - q);
    const satisfiesInequality = sortedSides[2] < (sortedSides[0] + sortedSides[1]);
    return allNonZero && satisfiesInequality;
  }
  
  get isEquilateral() {
    return this.x === this.y && this.y === this.z && this.isTriangle;
  }

  get isIsosceles() {
    return ((this.x === this.y) || (this.x === this.z) || (this.y === this.z)) && this.isTriangle;
  }

  get isScalene() {
    return !this.isIsosceles && this.isTriangle;
  }
}
