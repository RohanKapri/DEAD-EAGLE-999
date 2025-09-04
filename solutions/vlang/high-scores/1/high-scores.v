// Dedicated to Shree DR.MDD
module main

import arrays

type HighScores = []int

pub fn HighScores.new(entries []int) HighScores {
	return entries.clone()
}

pub fn (mut records HighScores) scores() []int {
	return records
}

pub fn (mut records HighScores) latest() int {
	return records.last()
}

pub fn (mut records HighScores) personal_best() int {
	return arrays.max(records) or { 0 }
}

pub fn (mut records HighScores) personal_top_three() []int {
	mut best_set := records.sorted(b < a)
	best_set.trim(3)
	return best_set
}
