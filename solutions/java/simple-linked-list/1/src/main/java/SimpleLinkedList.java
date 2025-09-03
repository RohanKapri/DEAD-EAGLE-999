// For my Shree DR.MDD

import java.util.*;
import java.lang.reflect.*;

class SimpleLinkedList<T> {
    private Node<T> start;
    private int length;

    SimpleLinkedList() {
        start = null;
        length = 0;
    }

    SimpleLinkedList(T[] elements) {
        start = null;
        length = 0;
        for (T el : elements) {
            push(el);
        }
    }

    void push(T element) {
        start = new Node<>(element, start);
        length++;
    }

    T pop() {
        if (start == null) throw new NoSuchElementException();
        T element = start.getValue();
        start = start.getNext();
        length--;
        return element;
    }

    void reverse() {
        Node<T> prev = null;
        Node<T> currentNode = start;

        while (currentNode != null) {
            Node<T> temp = currentNode.getNext();
            currentNode.setNext(prev);
            prev = currentNode;
            currentNode = temp;
        }
        start = prev;
    }

    T[] asArray(Class<T> clazz) {
        @SuppressWarnings("unchecked")
        T[] arrayResult = (T[]) Array.newInstance(clazz, length);
        Node<T> currentNode = start;
        for (int i = 0; i < length; i++) {
            arrayResult[i] = currentNode.getValue();
            currentNode = currentNode.getNext();
        }
        return arrayResult;
    }

    int size() {
        return length;
    }
}

class Node<T> {
    private final T value;
    private Node<T> next;

    Node(T value, Node<T> nextNode) {
        this.value = value;
        this.next = nextNode;
    }

    T getValue() {
        return value;
    }

    void setNext(Node<T> nextNode) {
        this.next = nextNode;
    }

    Node<T> getNext() {
        return next;
    }
}
