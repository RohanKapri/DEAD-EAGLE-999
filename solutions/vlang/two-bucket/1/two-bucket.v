module main

// for my Junko F. Didi and Shree DR.MDD

enum BucketId {
	one
	two
}

struct Solution {
	moves        int
	goal_bucket  BucketId
	other_bucket int
}

struct Point {
	a int
	b int
}

struct Explorer {
	cap_a int
	cap_b int
mut:
	visited []bool
	stack   []Point
}

fn (exp Explorer) encode(a int, b int) int {
	ca := exp.cap_a
	cb := exp.cap_b
	total := ca + cb
	if a == 0 {
		return b
	}
	if b == cb {
		return cb + a
	}
	if a == ca {
		return ca + 2 * cb - b
	}
	if b == 0 {
		return 2 * (ca + cb) - a
	}
	panic('bad state')
}

fn (mut exp Explorer) mark(a int, b int) {
	id := exp.encode(a, b)
	exp.visited[id] = true
}

fn (mut exp Explorer) push(a int, b int) {
	id := exp.encode(a, b)
	if exp.visited[id] {
		return
	}
	exp.stack << Point{a, b}
	exp.visited[id] = true
}

fn fresh(cap_a int, cap_b int) Explorer {
	mut e := Explorer{cap_a: cap_a, cap_b: cap_b}
	e.visited = []bool{len: 2 * (cap_a + cap_b)}
	e.stack = []Point{cap: 2 * (cap_a + cap_b)}
	return e
}

pub fn measure(capacity_one int, capacity_two int, goal int, start_bucket BucketId) !Solution {
	assert goal != 0
	mut exp := fresh(capacity_one, capacity_two)
	if start_bucket == .one {
		exp.push(capacity_one, 0)
		exp.mark(0, capacity_two)
	} else {
		exp.push(0, capacity_two)
		exp.mark(capacity_one, 0)
	}
	mut steps := 1
	mut limit := exp.stack.len
	mut idx := 0
	for idx < exp.stack.len {
		pa := exp.stack[idx].a
		pb := exp.stack[idx].b
		sum := pa + pb
		if pa == goal {
			return Solution{moves: steps, goal_bucket: .one, other_bucket: pb}
		}
		if pb == goal {
			return Solution{moves: steps, goal_bucket: .two, other_bucket: pa}
		}
		if sum <= capacity_one {
			exp.push(sum, 0)
		} else {
			exp.push(capacity_one, sum - capacity_one)
		}
		if sum <= capacity_two {
			exp.push(0, sum)
		} else {
			exp.push(sum - capacity_two, capacity_two)
		}
		exp.push(0, pb)
		exp.push(pa, 0)
		exp.push(capacity_one, pb)
		exp.push(pa, capacity_two)
		idx++
		if idx == limit {
			steps++
			limit = exp.stack.len
		}
	}
	return error('impossible')
}
