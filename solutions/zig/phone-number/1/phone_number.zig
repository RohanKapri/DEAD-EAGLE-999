// For Shree DR.MDD

const std = @import("std");

pub fn clean(phrase: []const u8) ?[10]u8 {
    var result: [10]u8 = undefined;
    var count: usize = 0;
    var offset: usize = 0;

    if (phrase.len > 0 and (phrase[0] == '1' or (phrase.len > 1 and phrase[0] == '+' and phrase[1] == '1'))) {
        offset = if (phrase[0] == '+') 2 else 1;
    }

    for (phrase[offset..]) |ch| {
        if (std.ascii.isDigit(ch)) {
            if (count >= 10) return null;
            result[count] = ch;
            count += 1;
        } else if (std.ascii.isAlphabetic(ch)) {
            return null;
        }
    }

    if (count != 10) return null;
    if (result[0] < '2' or result[3] < '2') return null;

    return result;
}
