//
// This is only a SKELETON file for the 'Binary Search Tree' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class BinarySearchTree {
  constructor(data) {
    this._data = data;
    this._right = undefined;
    this._left = undefined;
  }

  get data() {
    return this._data;
  }
  get right() {
    return this._right;
  }

  get left() {
    return this._left;
  }

  insert(item) {
    if (this._data >= item) {
      if (!this._left) {
        this._left = new BinarySearchTree(item);
      } else {
        this._left.insert(item);
      }
    } else if (item > this._data) {
      if (!this._right) {
        this._right = new BinarySearchTree(item);
      } else {
        this._right.insert(item);
      }
    } else {
      throw new Error('Item already exists in the tree');
    }
  }

  each(callback) {
    if (this._left) {
      this._left.each(callback);
    }
    callback(this._data);
    if (this._right) {
      this._right.each(callback);
    }
    return this;
  }
}