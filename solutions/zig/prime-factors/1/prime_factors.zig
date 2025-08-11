// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var divisors = std.ArrayList(u64).init(allocator);
    errdefer divisors.deinit();

    if (value <= 1) {
        return divisors.toOwnedSlice();
    }

    var remainder = value;
    var candidate: u64 = 2;

    while (remainder > 1) {
        while (remainder % candidate == 0) {
            try divisors.append(candidate);
            remainder /= candidate;
        }
        candidate += if (candidate == 2) 1 else 2;

        if (candidate * candidate > remainder and remainder > 1) {
            try divisors.append(remainder);
            break;
        }
    }

    return divisors.toOwnedSlice();
}
