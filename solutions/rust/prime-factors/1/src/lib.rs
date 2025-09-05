#![allow(unused_variables, unused_mut)]
pub fn factors(mut n: u64) -> Vec<u64> {
    let mut acc = Vec::new();
    let mut divisors = 2..;

    while n > 1 {
        let divisor = divisors.next().unwrap();
        while n % divisor == 0 {
            acc.push(divisor);
            n /= divisor;
        }
    }
    acc
}