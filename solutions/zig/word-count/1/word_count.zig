const std = @import("std");
const mem = std.mem;

pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    const lower: []const u8 = try std.ascii.allocLowerString(allocator, s);
    defer allocator.free(lower);

    var map = std.StringHashMap(u32).init(allocator);

    var iter = std.mem.splitAny(u8, lower, " ,.:;|!&@$%^\n\t\r");

    while (iter.next()) |token| {
        const word = std.mem.trim(u8, token, "'");
        if (word.len == 0) continue;

        const value = map.get(word);
        if (value) |v| {
            try map.put(word, v + 1);
        } else {
            const key = try allocator.dupe(u8, word);
            try map.put(key, 1);
        }
    }

    return map;
}