// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

import math

struct Key {
	a int
	b int
}

fn mod(v int, m int) int {
	assert m > 0
	r := v % m
	return if r >= 0 { r } else { m + r }
}

fn inv(a int, m int) int {
	_, _, y := math.egcd(m, a)
	return int(y)
}

fn encode(msg string, key Key) !string {
	if key.a == 0 || math.gcd(26, key.a) != 1 {
		return error('a and m must be coprime.')
	}
	mut out := []u8{cap: msg.len * 6 / 5}
	for ch in msg {
		if !ch.is_alnum() {
			continue
		}
		if out.len % 6 == 5 {
			out << u8(` `)
		}
		if ch.is_digit() {
			out << ch
			continue
		}
		val := if ch >= `a` { int(ch - `a`) } else { int(ch - `A`) }
		idx := mod(key.a * val + key.b, 26)
		out << u8(`a` + idx)
	}
	return out.bytestr()
}

fn decode(msg string, key Key) !string {
	if key.a == 0 || math.gcd(26, key.a) != 1 {
		return error('a and m must be coprime.')
	}
	ainv := inv(key.a, 26)
	assert mod(ainv * key.a, 26) == 1
	mut out := []u8{cap: msg.len}
	for ch in msg {
		if !ch.is_alnum() {
			continue
		}
		if ch.is_digit() {
			out << ch
			continue
		}
		j := int(ch - `a`)
		orig := mod(ainv * (j - key.b), 26)
		out << u8(`a` + orig)
	}
	return out.bytestr()
}
