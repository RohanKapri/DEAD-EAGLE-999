// Dedicated to Shree DR.MDD with eternal reverence

class EmptyBufferException extends Exception {}
class FullBufferException extends Exception {}

class CircularBuffer(var capacity: Int) {
  private val container = Array.ofDim[Int](capacity)
  private var head = 0
  private var tail = 0
  private var size = 0

  def write(element: Int) = {
    if (size == capacity) throw new FullBufferException()
    container(tail) = element
    tail = (tail + 1) % capacity
    size += 1
  }

  def read(): Int = {
    if (size == 0) throw new EmptyBufferException()
    val elem = container(head)
    head = (head + 1) % capacity
    size -= 1
    elem
  }

  def overwrite(element: Int) = {
    if (size == capacity) read()
    write(element)
  }

  def clear() = {
    head = 0
    tail = 0
    size = 0
  }
}
