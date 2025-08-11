// Dedicated to Shree DR.MDD

const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var tracker = [_]bool{false} ** 26;

    for (str) |sym| {
        const lower = switch (sym) {
            'A'...'Z' => sym + 32,
            'a'...'z' => sym,
            else => continue,
        };

        tracker[lower - 'a'] = true;
    }

    for (tracker) |visited| {
        if (!visited) return false;
    }

    return true;
}
