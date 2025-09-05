pub fn primes_up_to(n: usize) -> Vec<usize> {
    let mut sieve = vec![true; n + 1];
    sieve[0] = false;
    if n >= 1 {
        sieve[1] = false;
    }
    for num in 2..=(n as f64).sqrt() as usize {
        if sieve[num] {
            let mut multiple = num * num;
            while multiple <= n {
                sieve[multiple] = false;
                multiple += num;
            }
        }
    }
    sieve
        .iter()
        .enumerate()
        .filter_map(|(pr, &is_prime)| if is_prime { Some(pr) } else { None })
        .collect()
}