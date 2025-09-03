//
// For my Shree DR.MDD
//

export class List {
  constructor(items = []) {
    this.values = items;
  }

  compare(other) {
    if (this._arraysEqual(this.values, other.values)) {
      return 'EQUAL';
    } else if (this._isSublist(this.values, other.values)) {
      return 'SUBLIST';
    } else if (this._isSublist(other.values, this.values)) {
      return 'SUPERLIST';
    }
    return 'UNEQUAL';
  }

  _arraysEqual(arr1, arr2) {
    if (arr1.length !== arr2.length) return false;
    for (let i = 0; i < arr1.length; i++) {
      if (arr1[i] !== arr2[i]) return false;
    }
    return true;
  }

  _isSublist(sub, main) {
    const subLen = sub.length;
    const mainLen = main.length;
    if (subLen > mainLen) return false;
    for (let start = 0; start <= mainLen - subLen; start++) {
      const segment = main.slice(start, start + subLen);
      if (this._arraysEqual(segment, sub)) return true;
    }
    return false;
  }
}
