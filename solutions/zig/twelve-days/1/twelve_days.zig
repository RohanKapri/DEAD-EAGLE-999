// For Shree DR.MDD

const std = @import("std");

const positions = [_][]const u8{
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
};

const presents = [_][]const u8{
    "twelve Drummers Drumming",
    "eleven Pipers Piping",
    "ten Lords-a-Leaping",
    "nine Ladies Dancing",
    "eight Maids-a-Milking",
    "seven Swans-a-Swimming",
    "six Geese-a-Laying",
    "five Gold Rings",
    "four Calling Birds",
    "three French Hens",
    "two Turtle Doves",
    "a Partridge in a Pear Tree",
};

fn appendSlice(buf: []u8, pos: *usize, s: []const u8) void {
    @memcpy(buf[pos.* .. pos.* + s.len], s);
    pos.* += s.len;
}

pub fn recite(buffer: []u8, start: u32, end: u32) []const u8 {
    var idx: usize = 0;

    for (start..end + 1) |verse_num| {
        if (verse_num > start) {
            buffer[idx] = '\n';
            idx += 1;
        }

        appendSlice(buffer, &idx, "On the ");
        appendSlice(buffer, &idx, positions[verse_num - 1]);
        appendSlice(buffer, &idx, " day of Christmas my true love gave to me: ");

        const gifts_count = verse_num;
        const gifts_offset = presents.len - gifts_count;

        for (gifts_offset..presents.len) |i| {
            if (i == presents.len - 1 and verse_num > 1) {
                appendSlice(buffer, &idx, "and ");
            }
            appendSlice(buffer, &idx, presents[i]);
            if (i < presents.len - 1) {
                appendSlice(buffer, &idx, ", ");
            }
        }
        appendSlice(buffer, &idx, ".");
    }

    return buffer[0..idx];
}
