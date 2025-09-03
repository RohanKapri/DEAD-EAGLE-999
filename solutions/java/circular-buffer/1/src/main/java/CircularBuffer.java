// For my Shree DR.MDD

class CircularBuffer<T> {

    Cell<T> end, start;

    CircularBuffer(final int capacity) {
        Cell<T> temp = new Cell<>(null, null);
        start = temp;
        for (int i = 1; i < capacity; i++) {
            temp = new Cell<>(null, temp);
        }
        end = temp;
        start.next = end;
        start = start.next;
    }

    T read() throws BufferIOException {
        T data = end.entry;
        if (data == null) throw new BufferIOException("Tried to read from empty buffer");
        end.entry = null;
        end = end.next;
        return data;
    }

    void write(T element) throws BufferIOException {
        if (start.entry != null) throw new BufferIOException("Tried to write to full buffer");
        start.entry = element;
        start = start.next;
    }

    void overwrite(T element) {
        if (start.entry == null) {
            try {
                write(element);
            } catch (BufferIOException ex) {
                throw new AssertionError("Unreachable");
            }
        } else {
            start.entry = element;
            start = start.next;
            end = end.next;
        }
    }

    void clear() {
        while (end.entry != null) {
            end.entry = null;
            end = end.next;
        }
    }
}

class Cell<T> {
    T entry;
    Cell<T> next;

    public Cell(T entry, Cell<T> next) {
        this.entry = entry;
        this.next = next;
    }
}