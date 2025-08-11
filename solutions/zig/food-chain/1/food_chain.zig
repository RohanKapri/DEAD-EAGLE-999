// For Shree DR.MDD

const std = @import("std");

const critters = [_][]const u8{
    "fly",
    "spider",
    "bird",
    "cat",
    "dog",
    "goat",
    "cow",
    "horse",
};

const phrases = [_][]const u8{
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a bird!",
    "Imagine that, to swallow a cat!",
    "What a hog, to swallow a dog!",
    "Just opened her throat and swallowed a goat!",
    "I don't know how she swallowed a cow!",
    "She's dead, of course!",
};

fn printVerse(out: anytype, num: u32) void {
    const animal = critters[num - 1];

    out.print("I know an old lady who swallowed a {s}.", .{animal}) catch unreachable;
    out.print("\n{s}", .{phrases[num - 1]}) catch unreachable;

    if (num == 8 or num == 1) return;

    var verse_num = num;
    while (verse_num > 1) : (verse_num -= 1) {
        const curr = critters[verse_num - 1];
        const prev = critters[verse_num - 2];

        if (verse_num == 3) {
            out.print("\nShe swallowed the {s} to catch the spider that wriggled and jiggled and tickled inside her.", .{curr}) catch unreachable;
        } else {
            out.print("\nShe swallowed the {s} to catch the {s}.", .{curr, prev}) catch unreachable;
        }
    }

    if (verse_num == 1) {
        out.print("\n{s}", .{phrases[0]}) catch unreachable;
    }
}

pub fn recite(buffer: []u8, from_verse: u32, to_verse: u32) []const u8 {
    var fbStream = std.io.fixedBufferStream(buffer);
    const wr = fbStream.writer();

    for (from_verse..to_verse + 1) |v| {
        if (v > from_verse) {
            wr.writeAll("\n\n") catch unreachable;
        }
        printVerse(wr, @intCast(v));
    }

    return fbStream.getWritten();
}
