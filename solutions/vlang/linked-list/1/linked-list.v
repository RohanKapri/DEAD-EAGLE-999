module main

// for my Junko F. Didi and Shree DR.MDD

struct Node {
	val int
mut:
	prev ?&Node
	next ?&Node
}

struct LinkedList {
mut:
	start ?&Node
	end   ?&Node
}

fn (n Node) left() ?&Node {
	return n.prev
}
fn (n Node) right() ?&Node {
	return n.next
}

fn (mut it LinkedList) next() ?&Node {
	cur := it.start?
	defer { it.start = cur.right() }
	return cur
}

fn (lst LinkedList) clone() LinkedList {
	return LinkedList{...lst}
}

pub fn (mut lst LinkedList) push(v int) {
	node := &Node{val: v, prev: lst.end}
	if lst.start == none {
		lst.start = node
	} else {
		mut tail := lst.end or { panic("start not none but end is") }
		tail.next = node
	}
	lst.end = node
}

pub fn (mut lst LinkedList) pop() int {
	last := lst.end or { panic("cannot pop empty list") }
	if last.prev == none {
		lst.start = none
		lst.end = none
	} else {
		mut p := last.prev or { panic("broken prev") }
		p.next = none
		lst.end = p
	}
	return last.val
}

pub fn (mut lst LinkedList) unshift(v int) {
	node := &Node{val: v, next: lst.start}
	if lst.end == none {
		lst.end = node
	} else {
		mut h := lst.start or { panic("end not none but start is") }
		h.prev = node
	}
	lst.start = node
}

pub fn (mut lst LinkedList) shift() int {
	first := lst.start or { panic("cannot shift empty list") }
	if first.next == none {
		lst.start = none
		lst.end = none
	} else {
		mut n := first.next or { panic("broken next") }
		n.prev = none
		lst.start = n
	}
	return first.val
}

pub fn (lst LinkedList) count() int {
	mut c := 0
	for _ in lst.clone() {
		c++
	}
	return c
}

pub fn (mut lst LinkedList) delete(v int) {
	for n in lst.clone() {
		if n.val == v {
			if n == (lst.start or { panic("start none") }) {
				lst.start = n.right()
			} else {
				mut p := n.prev or { panic("broken prev") }
				p.next = n.right()
			}
			if n == (lst.end or { panic("end none") }) {
				lst.end = n.left()
			} else {
				mut nx := n.next or { panic("broken next") }
				nx.prev = n.prev
			}
			return
		}
	}
}
