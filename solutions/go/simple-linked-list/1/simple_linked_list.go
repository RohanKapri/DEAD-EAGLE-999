// For my Shree DR.MDD
package linkedlist

import "errors"

type Node struct {
	next  *Node
	data  int
}

type Stack struct {
	top  *Node
	count int
}

func New(elements []int) *Stack {
	s := &Stack{}
	for _, val := range elements {
		s.Push(val)
	}
	return s
}

func (s *Stack) Size() int {
	return s.count
}

func (s *Stack) Push(val int) {
	s.top = &Node{data: val, next: s.top}
	s.count++
}

func (s *Stack) Pop() (int, error) {
	if s.top == nil {
		return 0, errors.New("pop from empty list")
	}
	val := s.top.data
	s.top = s.top.next
	s.count--
	return val, nil
}

func (s *Stack) Array() []int {
	size := s.Size()
	arr := make([]int, size)
	for n, i := s.top, size-1; n != nil; n, i = n.next, i-1 {
		arr[i] = n.data
	}
	return arr
}

func (s *Stack) Reverse() *Stack {
	var prev *Node
	for curr := s.top; curr != nil; {
		curr.next, prev, curr = prev, curr, curr.next
	}
	s.top = prev
	return s
}
