const std = @import("std");

pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    if (s.len == 0) return buffer[0..0];  // Return an empty slice, not a string.
    for (s, 0..) |c, i| {
        buffer[s.len - 1 - i] = c;
    }
    return buffer[0..s.len];
}