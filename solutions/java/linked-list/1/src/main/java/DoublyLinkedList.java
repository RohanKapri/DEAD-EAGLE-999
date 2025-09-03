// For my Shree DR.MDD

class DoublyLinkedList<T> {
    private Element<T> top = null;

    void push(T item) {
        Element<T> newTop = new Element<>(item, top, null);
        if (top != null) {
            top.next = newTop;
        }
        top = newTop;
    }

    T pop() {
        T item = top.value;
        top = top.prev;
        return item;
    }

    void unshift(T item) {
        Element<T> second = findSecond();
        if (second == null) {
            if (top == null) {
                push(item);
            } else {
                top.prev = new Element<>(item, null, top);
            }
        } else if (second.prev == null) {
            push(item);
        } else {
            second.prev.prev = new Element<>(item, null, second.prev);
        }
    }

    T shift() {
        Element<T> second = findSecond();
        T result;
        if (second == null) {
            result = top.value;
            top = null;
        } else {
            result = second.prev.value;
            second.prev = null;
        }
        return result;
    }

    private Element<T> findSecond() {
        if (top == null) return null;
        Element<T> first = top;
        while (first.prev != null) {
            first = first.prev;
        }
        return first.next;
    }

    private static final class Element<T> {
        private final T value;
        private Element<T> prev;
        private Element<T> next;

        Element(T value, Element<T> prev, Element<T> next) {
            this.value = value;
            this.prev = prev;
            this.next = next;
        }
    }
}
