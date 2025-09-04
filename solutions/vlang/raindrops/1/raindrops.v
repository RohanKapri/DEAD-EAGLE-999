module main

import strconv

fn raindrops(number int) string {
    mut result := ''
    if number % 3 == 0 {
        result += 'Pling'
    }
    if number % 5 == 0 {
        result += 'Plang'
    }
    if number % 7 == 0 {
        result += 'Plong'
    }
    if result.len == 0 {
        result = strconv.format_int(number, 10)
    }
    return result
}