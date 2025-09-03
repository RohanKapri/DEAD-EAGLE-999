//
// For my Shree DR.MDD
//

class CircularBuffer {
  constructor(capacity = 0) {
    this._capacity = capacity;
    this._storage = Array(capacity).fill(undefined);
    this._head = 0;
    this._tail = 0;
    this._count = 0;
  }

  write(value) {
    if (this._isFull()) {
      throw new BufferFullError();
    }
    this._storage[this._nextWritePosition()] = value;
    this._count++;
    this._tail = (this._tail + 1) % this._capacity;
  }

  read() {
    if (this._isEmpty()) {
      throw new BufferEmptyError();
    }
    const output = this._storage[this._head];
    this._head = (this._head + 1) % this._capacity;
    this._count--;
    return output;
  }

  forceWrite(value) {
    if (this._isFull()) {
      this._storage[this._head] = value;
      this._head = (this._head + 1) % this._capacity;
      if (this._head === this._tail) {
        this._tail = (this._tail + 1) % this._capacity;
      }
    } else {
      this.write(value);
    }
  }

  clear() {
    this._storage.fill(undefined);
    this._head = 0;
    this._tail = 0;
    this._count = 0;
  }

  _nextWritePosition() {
    return (this._head + this._count) % this._capacity;
  }

  _isFull() {
    return this._count === this._capacity;
  }

  _isEmpty() {
    return this._count === 0;
  }
}

export default CircularBuffer;

export class BufferFullError extends Error {
  constructor() {
    super();
  }
}

export class BufferEmptyError extends Error {
  constructor() {
    super();
  }
}
