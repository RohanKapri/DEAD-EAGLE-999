class Zipper {
    
    private int value;
    
    BinaryTree tree;
    
    Zipper up;
    Zipper left;
    Zipper right;

    Zipper(int val) {
        this.value = val;
    }

    BinaryTree toTree() {
        Zipper current = this;
        while (current.up != null) {
            current = current.up;
        }
        return current.tree;
    }

    int getValue() {
        return value;
    }

    Zipper setLeft(Zipper leftChild) {
        left = leftChild;
        if (left != null) left.up = this;
        return left;
    }

    Zipper setRight(Zipper rightChild) {
        right = rightChild;
        if (right != null) right.up = this;
        return right;
    }

    void setValue(int val) {
        this.value = val;
    }
}

class BinaryTree {

    private Zipper root;
    
    BinaryTree(int value) {
        this.root = new Zipper(value);
        this.root.tree = this;
    }

    BinaryTree(Zipper root) {
        this.root = root;
        this.root.tree = this;
    }

    Zipper getRoot() {
        return root;
    }

    String printTree() {
        return printTree(root);
    }
    
    private String printTree(Zipper root) {
        return "value: " + root.getValue() + ", left: " + nullOrGet(root.left) + ", right: " + nullOrGet(root.right);
    }

    private String nullOrGet(Zipper root) {
        return root == null ? "null" : "{ " + printTree(root) + " }";
    }
}