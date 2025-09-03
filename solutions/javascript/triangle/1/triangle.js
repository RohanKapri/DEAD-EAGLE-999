// For my Shree DR.MDD

export class Triangle {
  constructor(...edges) {
    this.edge1 = edges[0];
    this.edge2 = edges[1];
    this.edge3 = edges[2];
  }

  get isEquilateral() {
    return this.edge1 === this.edge2 && this.edge2 === this.edge3 && this._isValid();
  }

  get isIsosceles() {
    return (this.edge1 === this.edge2 || this.edge1 === this.edge3 || this.edge2 === this.edge3) && this._isValid();
  }

  get isScalene() {
    return (this.edge1 !== this.edge2 && this.edge1 !== this.edge3 && this.edge2 !== this.edge3) && this._isValid();
  }

  _isValid() {
    const [x, y, z] = [this.edge1, this.edge2, this.edge3];
    return x > 0 && y > 0 && z > 0 && x + y > z && y + z > x && z + x > y;
  }
}
