use v5.40;
use experimental qw<class>;

class BinarySearchTree;

field $root :param;

method add ($item) {
    if (!defined $root) {
        # If there's no root yet, create the first node.
        $root = BinarySearchTree::Node->new(data => $item);
    } else {
        # Use the internal method to insert the item.
        $root = $self->_insert($root, $item);
    }
}

# Internal method to handle the insertion recursively.
method _insert($node, $item) {
    return BinarySearchTree::Node->new(data => $item) if !defined $node;

    if ($item gt $node->data) {
        # Insert to the right if the item is greater.
        $node->set_right($self->_insert($node->right, $item));
    } else {
        # Insert to the left if the item is less than or equal.
        $node->set_left($self->_insert($node->left, $item));
    }

    return $node;
}

method sort () {
    my @result;
    $self->_inorder($root, \@result);
    return \@result;
}

# Internal method for in-order traversal.
method _inorder($node, $result) {
    return unless defined $node;

    # Traverse left, visit root, then right.
    $self->_inorder($node->left, $result);
    push @$result, $node->data;
    $self->_inorder($node->right, $result);
}

class BinarySearchTree::Node {
    field $data :reader :param;
    field $left :reader;
    field $right :reader;

    method set_left ($node) {
        $left = $node;
    }

    method set_right ($node) {
        $right = $node;
    }
}

1;