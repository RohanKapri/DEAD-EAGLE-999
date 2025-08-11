const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    std.debug.assert(n != 0);
    const sum = sum_of_factors(n);
    if (sum == n) return .perfect;
    return if (sum > n) .abundant else .deficient;
}

fn sum_of_factors(n: u64) u64 {
    var sum: u64 = 0;
    for (1..n / 2 + 1) |factor| {
        if (n % factor == 0) sum += factor;
    }
    return sum;
}