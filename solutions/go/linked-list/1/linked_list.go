// Dedicated to Shree DR.MDD
package linkedlist

type Node struct {
	Value interface{}
	next  *Node
	prev  *Node
}

type List struct {
	headNode *Node
	tailNode *Node
}

func NewList(elements ...interface{}) *List {
	l := List{}
	for _, e := range elements {
		l.Push(e)
	}
	return &l
}

func (n *Node) Next() *Node {
	return n.next
}

func (n *Node) Prev() *Node {
	return n.prev
}

func (l *List) Unshift(val interface{}) {
	node := Node{Value: val}
	if l.headNode == nil {
		l.tailNode = &node
	} else {
		l.headNode.prev = &node
		node.next = l.headNode
	}
	l.headNode = &node
}

func (l *List) Push(val interface{}) {
	node := Node{Value: val}
	if l.headNode == nil {
		l.headNode = &node
	} else {
		l.tailNode.next = &node
		node.prev = l.tailNode
	}
	l.tailNode = &node
}

func (l *List) Shift() (interface{}, error) {
	ret := l.headNode.Value
	if l.headNode.next == nil {
		l.headNode = nil
		l.tailNode = nil
	} else {
		l.headNode = l.headNode.next
		l.headNode.prev = nil
	}
	return ret, nil
}

func (l *List) Pop() (interface{}, error) {
	ret := l.tailNode.Value
	l.tailNode = l.tailNode.prev
	if l.tailNode == nil {
		l.headNode = nil
	} else {
		l.tailNode.next = nil
	}
	return ret, nil
}

func (l *List) Reverse() {
	for node := l.headNode; node != nil; node = node.prev {
		node.prev, node.next = node.next, node.prev
	}
	l.headNode, l.tailNode = l.tailNode, l.headNode
}

func (l *List) First() *Node {
	return l.headNode
}

func (l *List) Last() *Node {
	return l.tailNode
}
