// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub const Item = struct {
    weight: usize,
    value: usize,

    pub fn init(weight: usize, value: usize) Item {
        return Item{ .weight = weight, .value = value };
    }
};

pub fn maximumValue(allocator: mem.Allocator, maximumWeight: usize, items: []const Item) !usize {
    const row_count = items.len + 1;
    const col_count = maximumWeight + 1;

    var table = try allocator.alloc([]usize, row_count);
    defer allocator.free(table);

    for (table) |*r| {
        r.* = try allocator.alloc(usize, col_count);
    }
    defer {
        for (table) |r| {
            allocator.free(r);
        }
    }

    @memset(table[0], 0);

    for (items, 0..) |it, idx| {
        const r_idx = idx + 1;
        for (0..col_count) |cap| {
            if (it.weight > cap) {
                table[r_idx][cap] = table[r_idx - 1][cap];
            } else {
                table[r_idx][cap] = @max(
                    table[r_idx - 1][cap],
                    it.value + table[r_idx - 1][cap - it.weight]
                );
            }
        }
    }

    return table[row_count - 1][col_count - 1];
}
