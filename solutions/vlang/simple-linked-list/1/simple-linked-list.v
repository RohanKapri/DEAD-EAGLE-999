module main

struct Node {
	data int
mut:
	next &Node = unsafe { nil }
}

struct LinkedList {
mut:
	node &Node = unsafe { nil }
	len  int
}

fn new() LinkedList {
	return LinkedList{}
}

fn from_array(array []int) LinkedList {
	mut list := new()

	for item in array {
		list.push(item)
	}

	return list
}

fn (list LinkedList) is_empty() bool {
	return list.len == 0
}

fn (mut list LinkedList) push(data int) {
	head := &Node{
		data: data
		next: list.node
	}

	list.node = head
	list.len++
}

fn (mut list LinkedList) pop() ?int {
	if list.is_empty() {
		return none
	}

	data := list.node.data
	list.node = list.node.next
	list.len--
	return data
}

fn (list LinkedList) peek() ?int {
	if list.node == unsafe { nil } {
		return none
	}

	return list.node.data
}

fn (list LinkedList) to_array() []int {
	mut array := []int{cap: list.len}
	for current := list.node; current != unsafe { nil }; current = current.next {
		array << current.data
	}

	return array.reverse()
}

fn (list LinkedList) reverse() LinkedList {
	mut new_list := new()
	for current := list.node; current != unsafe { nil }; current = current.next {
		new_list.push(current.data)
	}

	return new_list
}