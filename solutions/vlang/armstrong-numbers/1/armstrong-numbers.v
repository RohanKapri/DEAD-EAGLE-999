module main

import math

pub fn is_armstrong_number(number u32) bool {
    mut digits := []u32{}
    mut n := number
    for n != 0 {
        digits << n % 10
        n = n / 10
    }
    mut sum := i64(0)
    for digit in digits {
        sum += math.powi(digit, digits.len)
    }
    return sum == number
}