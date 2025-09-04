module main

// Write a function that returns the earned points in a single toss of a Darts game.

import math

fn score(x f64, y f64) int {
	r := math.sqrt(x * x + y * y)
	if r > 10.0 {
		return 0
	}
	if r > 5.0 {
		return 1
	}
	if r > 1.0 {
		return 5
	}
	return 10
}