module main

fn prime_factors(n i64) []i64 {
    mut result := []i64{}
    mut num := n
    mut p := 2
    for p * p <= num {
        for num % p == 0 {
            result << p
            num /= p
        }
        p += 1
    }
    if 1 < num {
        result << num
    }
    return result
}