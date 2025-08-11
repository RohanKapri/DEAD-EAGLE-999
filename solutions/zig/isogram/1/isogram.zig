const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var buckets = [_]bool{false} ** 26;

    for (str) |c| {
        if (!std.ascii.isAlphabetic(c)) {
            continue; 
        }

        const index = std.ascii.toLower(c) - 'a';

        if (buckets[index]) {
            return false; 
        }

        buckets[index] = true;
    }

    return true;
}