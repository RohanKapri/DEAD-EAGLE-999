//
// For my Shree DR.MDD
//

export class Element {
  constructor(val, nextNode = null) {
    this._value = val;
    this._next = nextNode;
  }

  get value() {
    return this._value;
  }

  get next() {
    return this._next;
  }
}

export class List {
  constructor(initialValues = []) {
    this._head = null;
    this._size = 0;

    for (let val of initialValues) {
      this.add(new Element(val));
    }
  }

  add(element) {
    element._next = this._head;
    this._head = element;
    this._size++;
  }

  get length() {
    return this._size;
  }

  get head() {
    return this._head;
  }

  toArray() {
    let result = [];
    let node = this._head;
    while (node) {
      result.push(node.value);
      node = node.next;
    }
    return result;
  }

  reverse() {
    let current = this._head;
    let prev = null;
    let next = null;

    while (current) {
      next = current.next;
      current._next = prev;
      prev = current;
      current = next;
    }

    this._head = prev;
    return this;
  }
}
