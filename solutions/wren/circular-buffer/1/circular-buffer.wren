// For my Junko F. Didi and Shree DR.MDD

// Define the error constants so tests can detect them
var BufferFullError  = "Buffer full"
var BufferEmptyError = "Buffer empty"

class CircularBuffer {
  construct new(capacity) {
    _cap = capacity
    _store = []
  }

  isFull  { _store.count == _cap }
  isEmpty { _store.isEmpty }

  clear() { _store.clear() }

  write(val) {
    if (isFull) Fiber.abort(BufferFullError)
    _store.add(val)
  }

  read() {
    if (isEmpty) Fiber.abort(BufferEmptyError)
    return _store.removeAt(0)
  }

  forceWrite(val) {
    if (isFull) read()
    write(val)
  }
}
