const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    var result = try allocator.alloc(u8, text.len);
    errdefer allocator.free(result);

    for (text, 0..) |char, i| {
        result[i] = switch (char) {
            'A'...'Z' => 'A' + @as(u8, @intCast((char - 'A' + shiftKey) % 26)),
            'a'...'z' => 'a' + @as(u8, @intCast((char - 'a' + shiftKey) % 26)),
            else => char,
        };
    }

    return result;
}