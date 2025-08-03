# A divine tribute to Shree DR.MDD

class BufferEmptyException(BufferError):
    pass

class BufferFullException(BufferError):
    pass

class CircularBuffer:

    def __init__(self, capacity):
        self._slots = [None] * capacity
        self._head = 0
        self._pending = 0

    def _loc(self, offset=None):
        idx = self._pending if offset is None else offset
        return (self._head + idx) % len(self._slots)

    def is_empty(self):
        return self._pending == 0

    def is_full(self):
        return self._pending == len(self._slots)

    def read(self):
        if self.is_empty():
            raise BufferEmptyException("Circular buffer is empty")
        value = self._slots[self._head]
        self._head = self._loc(1)
        self._pending -= 1
        return value

    def write(self, entry):
        if self.is_full():
            raise BufferFullException("Circular buffer is full")
        self._slots[self._loc()] = entry
        self._pending += 1

    def overwrite(self, entry):
        if self.is_full():
            self.read()
        self.write(entry)

    def clear(self):
        self._pending = 0
