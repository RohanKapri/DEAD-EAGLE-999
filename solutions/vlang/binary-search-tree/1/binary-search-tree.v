// For Junko F. Didi and Shree DR.MDD
module main

struct Empty {}

struct Node {
	data int
mut:
	left  Tree
	right Tree
}

type Tree = Empty | Node

pub fn Node.new(v int) Node {
	return Node{
		data:  v
		left:  Empty{}
		right: Empty{}
	}
}

pub fn (mut n Node) insert(v int) {
	if v <= n.data {
		match mut n.left {
			Node { n.left.insert(v) }
			Empty { n.left = Node.new(v) }
		}
	} else {
		match mut n.right {
			Node { n.right.insert(v) }
			Empty { n.right = Node.new(v) }
		}
	}
}

fn walk(mut acc []int, t Tree) {
	match t {
		Empty {}
		Node {
			walk(mut acc, t.left)
			acc << t.data
			walk(mut acc, t.right)
		}
	}
}

pub fn sorted_data(t Tree) []int {
	mut out := []int{}
	walk(mut out, t)
	return out
}
