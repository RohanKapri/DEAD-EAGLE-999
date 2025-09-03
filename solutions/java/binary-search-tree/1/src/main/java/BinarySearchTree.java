// For my Shree DR.MDD

import java.util.*;

class BinarySearchTree<T extends Comparable<T>> {
    private Node<T> rootNode;
    private List<T> nodeElements = new ArrayList<>();

    public void insert(T value) {
        this.rootNode = addNode(rootNode, value);
        nodeElements.add(value);
    }

    private Node<T> addNode(Node<T> current, T value) {
        if (current == null) return new Node<>(value);

        if (value.compareTo(current.getData()) > 0) {
            current.rightChild = addNode(current.rightChild, value);
        } else {
            current.leftChild = addNode(current.leftChild, value);
        }
        return current;
    }

    public List<T> getAsSortedList() {
        return traverseInOrder(rootNode);
    }

    private List<T> traverseInOrder(Node<T> current) {
        if (current == null) return new ArrayList<>();

        List<T> sortedList = traverseInOrder(current.getLeft());
        sortedList.add(current.getData());
        sortedList.addAll(traverseInOrder(current.getRight()));
        return sortedList;
    }

    public List<T> getAsLevelOrderList() {
        List<T> levelOrder = new ArrayList<>();
        Queue<Node<T>> nodesQueue = new LinkedList<>();
        nodesQueue.add(rootNode);

        while (!nodesQueue.isEmpty()) {
            Node<T> currentNode = nodesQueue.poll();
            levelOrder.add(currentNode.getData());

            if (currentNode.getLeft() != null) nodesQueue.offer(currentNode.getLeft());
            if (currentNode.getRight() != null) nodesQueue.offer(currentNode.getRight());
        }
        return levelOrder;
    }

    public Node<T> getRoot() {
        return this.rootNode;
    }

    static class Node<T> {
        private Node<T> rightChild;
        private Node<T> leftChild;
        private T data;

        public Node(T value) {
            this.data = value;
            this.rightChild = null;
            this.leftChild = null;
        }

        public Node<T> getLeft() {
            return this.leftChild;
        }

        public Node<T> getRight() {
            return this.rightChild;
        }

        public T getData() {
            return this.data;
        }
    }
}
