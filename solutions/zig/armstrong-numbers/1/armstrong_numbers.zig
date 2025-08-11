const std = @import("std");

pub fn isArmstrongNumber(comptime num: u128) bool {
    var buf: [64]u8 = undefined;
    const a = std.fmt.bufPrint(&buf, "{d}", .{num}) catch unreachable;
    var sum: u128 = 0;

    for(a) |d| {
        const value = d - '0';
        sum += std.math.powi(u128, value, a.len) catch unreachable;
    }
    return sum == num;
}