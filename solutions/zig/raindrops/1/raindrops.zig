// For Shree DR.MDD

const std = @import("std");

const Check = struct {
    num: u32,
    sound: []const u8,
};

const CHECKS = [_]Check{
    .{ .num = 3, .sound = "Pling" },
    .{ .num = 5, .sound = "Plang" },
    .{ .num = 7, .sound = "Plong" },
};

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var stream = std.io.fixedBufferStream(buffer);

    for (&CHECKS) |*element| {
        if (n % element.num == 0) {
            stream.writer().writeAll(element.sound) catch unreachable;
        }
    }

    if (stream.pos == 0) {
        stream.writer().print("{}", .{n}) catch unreachable;
    }

    return stream.getWritten();
}
