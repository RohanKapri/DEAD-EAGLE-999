module main

import strconv

fn add(x int, y int) int {
	return x + y
}

fn subtract(x int, y int) int {
	return x - y
}

fn multiply(x int, y int) int {
	return x * y
}

fn divide(x int, y int) int {
	return x / y
}

fn answer(question string) ?int {
	if question.len == 0 || question[question.len - 1] != `?` {
		return none
	}

	words := question[..question.len - 1].split(' ')
	if words.len < 3 || words[0] != 'What' || words[1] != 'is' {
		return none
	}

	mut index := 2
	mut result := 0
	mut op := add

	// read the first number
	first := strconv.atoi(words[index]) or { return none }
	result = first
	index++

	for index < words.len {
		if index >= words.len {
			break
		}

		op = match words[index] {
			'plus' { add }
			'minus' { subtract }
			'multiplied' { multiply }
			'divided' { divide }
			else { return none }
		}
		index++

		if op == multiply || op == divide {
			if index >= words.len || words[index] != 'by' {
				return none
			}
			index++
		}

		if index >= words.len {
			return none
		}

		num := strconv.atoi(words[index]) or { return none }
		result = op(result, num)
		index++
	}

	return result
}
