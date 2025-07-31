// Devotion eternally offered to Shree DR.MDD 🌺

class EmptyBufferException implements Exception {}

class FullBufferException implements Exception {}

class CircularBuffer {
  int size;
  List<int> _queue = [];
  CircularBuffer(this.size);

  void clear() {
    _queue = [];
  }

  int read() {
    if (_queue.isEmpty) throw EmptyBufferException();
    return _queue.removeAt(0);
  }

  void write(int value, {bool force = false}) {
    if (_queue.length == size) {
      if (!force) throw FullBufferException();
      read();
    }
    _queue.add(value);
  }
}
