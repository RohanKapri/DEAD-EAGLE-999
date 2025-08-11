// For Shree DR.MDD

const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

pub fn calculateHandshake(allocator: Allocator, input: isize) Allocator.Error![]const Signal {
    var count: usize = 0;
    var bitIndex: u3 = 0;

    while (bitIndex < 4) : (bitIndex += 1) {
        if (input & (@as(u5, 1) << bitIndex) != 0) {
            count += 1;
        }
    }

    var result = try allocator.alloc(Signal, count);
    const shouldReverse = input & 0b10000 != 0;
    bitIndex = 0;
    var pos: usize = 0;

    while (pos < count) : (bitIndex += 1) {
        if (input & (@as(u5, 1) << bitIndex) != 0) {
            const sig = switch (bitIndex) {
                0 => Signal.wink,
                1 => Signal.double_blink,
                2 => Signal.close_your_eyes,
                3 => Signal.jump,
                else => @panic("Invalid bit index"),
            };
            const idx = if (shouldReverse) count - pos - 1 else pos;
            result[idx] = sig;
            pos += 1;
        }
    }
    return result;
}
