pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    var primes_found: usize = 0;
    // Initialize an array with booleans prime markers
    var is_prime = [_]bool{true} ** (limit + 1);

    var n: u32 = 2;

    while (n <= limit) : (n += 1) {
        if (is_prime[n]) {
            buffer[primes_found] = n;
            primes_found += 1;
            var not_prime = n * 2;
            while (not_prime <= limit) : (not_prime += n) {
                is_prime[not_prime] = false;
            }
        }
    }

    return buffer[0..primes_found];
}