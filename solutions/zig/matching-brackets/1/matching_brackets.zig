const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var v = std.ArrayList(u8).init(allocator);
    defer v.deinit();

    for (s) |value| {
        switch (value) {
            '{' => try v.append('}'),
            '[' => try v.append(']'),
            '(' => try v.append(')'),
            '}', ']', ')' => if (v.pop() != value) return false,
            else => continue,
        }
    }

    return v.items.len == 0;
}