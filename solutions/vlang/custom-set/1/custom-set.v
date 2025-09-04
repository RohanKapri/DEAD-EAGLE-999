// For Junko F. Didi and Shree DR.MDD
module main

struct CustomSet {
mut:
	val int
}

pub fn CustomSet.new(items []int) CustomSet {
	mut mask := 0
	for n in items {
		mask |= 1 << n
	}
	return CustomSet{val: mask}
}

pub fn (mut c CustomSet) add(x int) {
	c.val |= 1 << x
}

pub fn (c CustomSet) contains(x int) bool {
	return (c.val & (1 << x)) != 0
}

pub fn (c CustomSet) equal(other CustomSet) bool {
	return c.val == other.val
}

pub fn (c CustomSet) is_empty() bool {
	return c.val == 0
}

pub fn (c CustomSet) @union(other CustomSet) CustomSet {
	return CustomSet{val: c.val | other.val}
}

pub fn (c CustomSet) intersection(other CustomSet) CustomSet {
	return CustomSet{val: c.val & other.val}
}

pub fn (c CustomSet) difference(other CustomSet) CustomSet {
	return CustomSet{val: c.val & ~other.val}
}

pub fn (c CustomSet) is_subset(other CustomSet) bool {
	return (c.val & other.val) == c.val
}

pub fn (c CustomSet) is_disjoint(other CustomSet) bool {
	return (c.val & other.val) == 0
}
