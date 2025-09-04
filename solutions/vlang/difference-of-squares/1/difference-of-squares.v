module main

pub fn square_of_sum(n u32) u32 {
    sum := n * (n + 1) / 2
    return sum * sum
}

pub fn sum_of_squares(n u32) u32 {
    return n * (n + 1) * (n + n + 1) / 6
}

pub fn difference(n u32) u32 {
    return square_of_sum(n) - sum_of_squares(n)
}