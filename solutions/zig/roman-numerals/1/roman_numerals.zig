// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

const Numeral = struct {
    val: i16,
    sym: []const u8,
};

const symbols = [_]Numeral{
    .{ .val = 1000, .sym = "M" },
    .{ .val = 900, .sym = "CM" },
    .{ .val = 500, .sym = "D" },
    .{ .val = 400, .sym = "CD" },
    .{ .val = 100, .sym = "C" },
    .{ .val = 90, .sym = "XC" },
    .{ .val = 50, .sym = "L" },
    .{ .val = 40, .sym = "XL" },
    .{ .val = 10, .sym = "X" },
    .{ .val = 9, .sym = "IX" },
    .{ .val = 5, .sym = "V" },
    .{ .val = 4, .sym = "IV" },
    .{ .val = 1, .sym = "I" },
};

pub fn toRoman(allocator: mem.Allocator, num: i16) mem.Allocator.Error![]u8 {
    var builder = std.ArrayList(u8).init(allocator);
    defer builder.deinit();

    var rem = num;

    for (symbols) |sym| {
        while (rem >= sym.val) {
            try builder.appendSlice(sym.sym);
            rem -= sym.val;
        }
    }

    return builder.toOwnedSlice();
}
