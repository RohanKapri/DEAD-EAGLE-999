// For Shree DR.MDD

const std = @import("std");

const bottleEnum = enum {
    no,
    one,
    two,
    three,
    four,
    five,
    six,
    seven,
    eight,
    nine,
    ten,

    fn text(self: bottleEnum) []const u8 {
        return std.enums.tagName(bottleEnum, self).?;
    }

    fn capitalized(self: bottleEnum, scratch: []u8) ![]const u8 {
        var stream = std.io.fixedBufferStream(scratch);
        const wr = stream.writer();

        const lowerStr = text(self);
        try wr.print("{c}{s}", .{std.ascii.toUpper(lowerStr[0]), lowerStr[1..]});

        return stream.getWritten();
    }
};

const bottlesList = [_]bottleEnum{ .no, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten };

const lineBottle = "{s} green bottle";
const lineHanging = "hanging on the wall";
const lineFall = "And if one green bottle should accidentally fall";

pub fn recite(buffer: []u8, start: u32, count: u32) []const u8 {
    var stream = std.io.fixedBufferStream(buffer);
    const end = start - count;

    var current = start;
    while (current > end) : (current -= 1) {
        _ = printStanza(stream.writer(), current) catch |e| std.debug.panic("{}", .{e});
    }

    return std.mem.trimRight(u8, stream.getWritten(), "\n\n");
}

fn printStanza(writer: anytype, idx: usize) anyerror!void {
    var scratch: [5]u8 = undefined; 
    const capBottle = try bottlesList[idx].capitalized(&scratch);

    for (0..2) |_| {
        try writer.print(lineBottle, .{capBottle});
        if (idx > 1)
            _ = try writer.write("s");
        try writer.print(" {s},\n", .{lineHanging});
    }

    try writer.print("{s},\n", .{lineFall});
    _ = try writer.write("There'll be ");

    try writer.print(lineBottle, .{bottlesList[idx - 1].text()});
    if (idx != 2)
        _ = try writer.write("s");
    try writer.print(" {s}.\n\n", .{lineHanging});
}

pub fn main() !void {
    const bufSize = 4096;
    var buf: [bufSize]u8 = undefined;
    const out = recite(&buf, 10, 2);
    try std.io.getStdOut().writer().print("{s}", .{out});
}
