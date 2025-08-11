// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub const PrimeError = error{
    InvalidInput,
};

fn checkPrime(x: usize) bool {
    if (x <= 1) return false;
    if (x <= 3) return true;
    if (x % 2 == 0 or x % 3 == 0) return false;

    var i: usize = 5;
    while (i * i <= x) : (i += 6) {
        if (x % i == 0 or x % (i + 2) == 0) return false;
    }

    return true;
}

pub fn prime(allocator: mem.Allocator, target: usize) !usize {
    _ = allocator;
    if (target == 0) return PrimeError.InvalidInput;

    var found: usize = 0;
    var candidate: usize = 1;

    while (found < target) : (candidate += 1) {
        if (checkPrime(candidate)) {
            found += 1;
        }
    }

    return candidate - 1;
}
