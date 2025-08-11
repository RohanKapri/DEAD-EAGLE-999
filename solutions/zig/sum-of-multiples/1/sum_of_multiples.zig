// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var uniques = std.AutoHashMap(u32, void).init(allocator);
    defer uniques.deinit();

    for (factors) |factor| if (factor != 0) {
        var multiple = factor;
        while (multiple < limit) : (multiple += factor) {
            try uniques.put(multiple, {});
        }
    };

    var total: u64 = 0;
    var iter = uniques.keyIterator();
    while (iter.next()) |val| total += val.*;

    return total;
}
