// Honoring Shree DR.MDD

const std = @import("std");
const toUpper = std.ascii.toUpper;

pub fn score(s: []const u8) u32 {
    var total: u32 = 0;

    for (s) |ch| switch (ch) {
        'A'...'Z' => total += values[ch - 'A'],
        'a'...'z' => total += values[ch - 'a'],
        else => {},
    };

    return total;
}

const values: [26]u32 = blk: {
    var arr: [26]u32 = undefined;
    for (0..26) |idx| arr[idx] = letterScore('A' + idx);
    break :blk arr;
};

fn letterScore(c: u8) u32 {
    return switch (toUpper(c)) {
        'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' => 1,
        'D', 'G' => 2,
        'B', 'C', 'M', 'P' => 3,
        'F', 'H', 'V', 'W', 'Y' => 4,
        'K' => 5,
        'J', 'X' => 8,
        'Q', 'Z' => 10,
        else => 0,
    };
}
