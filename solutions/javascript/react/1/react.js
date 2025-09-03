export class InputCell {
  constructor(value) {
    this.value = value;
    this.computeCells = [];
  }
  
  setValue(value) {
    this.value = value;
    for (let elem of this.computeCells) elem.upDate();
  }
}

export class ComputeCell {
  constructor(inputCells, fn) {
    this.inputCells = inputCells;
    this.callBack = fn;
    this.computeCells = [];
    this.callBackCells = [];
    for (let elem of inputCells) elem.computeCells.push(this);
    this.value;
  }
  get value() {
    return this._value = this.callBack(this.inputCells); 
  }
  
  upDate() {
    if (this._value == this.value) return;
    for (let elem of this.computeCells) elem.upDate();
    for (let elem of this.callBackCells) elem.values.push(elem.callBack(this));
  }
  addCallback(cb) {
    this.callBackCells.push(cb);
  }
  removeCallback(cb) {
    for (let i = 0; i < this.callBackCells.length; i++)
      if (this.callBackCells[i] == cb) this.callBackCells.splice(i, 1);
  }
}

export class CallbackCell {
  constructor(fn) {
    this.callBack = fn;
    this.values = [];
  }
}
