// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub fn translate(allocator: mem.Allocator, input: []const u8) mem.Allocator.Error![]u8 {
    const wordCount = countWords: {
        var c: usize = 1;
        for (input) |ch| {
            if (ch == ' ') c += 1;
        }
        break :countWords c;
    };
    const buffer: []u8 = try allocator.alloc(u8, input.len + 2 * wordCount);
    var fixedStream = std.io.fixedBufferStream(buffer);
    var outWriter = fixedStream.writer();
    var length: usize = 0;
    for (input) |ch| {
        if (ch == ' ') {
            addAySuffix(outWriter, length);
            length = 0;
        } else {
            length += 1;
        }
        outWriter.print("{c}", .{ch}) catch unreachable;
    } else {
        addAySuffix(outWriter, length);
    }
    return buffer;
}

fn addAySuffix(writer: anytype, len: usize) void {
    const position = writer.context.pos;
    const segment = writer.context.buffer[position - len .. position];
    if (!isVowel(segment[0]) and !isSpecialCase(segment)) {
        shiftLeft(segment);
        while ((segment[0] == 'u' and segment[len - 1] == 'q') or (!isVowel(segment[0]) and segment[0] != 'y')) {
            shiftLeft(segment);
        }
    }
    writer.print("ay", .{}) catch unreachable;
}

fn isVowel(ch: u8) bool {
    return switch (ch) {
        'a', 'e', 'i', 'o', 'u' => true,
        else => false,
    };
}

fn isSpecialCase(word: []u8) bool {
    if (word.len < 2) return false;
    return (word[0] == 'x' and word[1] == 'r') or (word[0] == 'y' and word[1] == 't');
}

fn shiftLeft(arr: []u8) void {
    const tmp = arr[0];
    for (1..arr.len) |i| {
        arr[i - 1] = arr[i];
    }
    arr[arr.len - 1] = tmp;
}

test "shiftLeft" {
    var arr = [_]u8{ 'a', 'b', 'c', 'd' };
    shiftLeft(&arr);
    try std.testing.expectEqualStrings("bcda", &arr);
}
