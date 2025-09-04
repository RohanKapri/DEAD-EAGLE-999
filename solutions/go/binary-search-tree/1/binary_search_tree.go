package binarysearchtree

type BinarySearchTree struct {
	left  *BinarySearchTree
	data  int
	right *BinarySearchTree
}

// NewBst creates and returns a new BinarySearchTree.
func NewBst(i int) *BinarySearchTree {
	return &BinarySearchTree{
		left:  nil,
		data:  i,
		right: nil,
	}
	// panic("Please implement the NewBst function")
}

// Insert inserts an int into the BinarySearchTree.
// Inserts happen based on the rules of a binary search tree
func (bst *BinarySearchTree) Insert(i int) {
	root := bst
	newNode := NewBst(i)
	for root != nil {
		if i <= root.data {
			// check if the left node is nil
			if root.left == nil {
				root.left = newNode
				break
			} else {
				root = root.left
			}
		} else {
			// check if the right node is nil
			if root.right == nil {
				root.right = newNode
				break
			} else {
				root = root.right
			}
		}
	}
	// panic("Please implement the Insert method")
}

// SortedData returns the ordered contents of BinarySearchTree as an []int.
// The values are in increasing order starting with the lowest int value.
// A BinarySearchTree that has the numbers [1,3,7,5] added will return the
// []int [1,3,5,7].
func (bst *BinarySearchTree) SortedData() []int {
	// go to the left most leaf node of the bst
	// then do left-root-right traversal till you reach the right most leaf node
	var res []int = make([]int, 0)
	inOrderTraversal(&res, bst)
	return res
	// panic("Please implement the SortedData function")
}

func inOrderTraversal(res *[]int, bst *BinarySearchTree) {
	// left side recursion till you reach the left most leaf node for the particular bst
	if bst.left != nil {
		inOrderTraversal(res, bst.left)
	}
	// append the node data to the result array
	*res = append(*res, bst.data)
	// right side recursion till you reach the right most leaf node for the particular bst
	if bst.right != nil {
		inOrderTraversal(res, bst.right)
	}
}