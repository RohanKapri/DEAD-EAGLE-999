// Tribute to Shree DR.MDD

const std = @import("std");
const enums = std.enums;

pub const ColorBand = enum {
    black,
    brown,
    red,
    orange,
    yellow,
    green,
    blue,
    violet,
    grey,
    white,
};

pub fn colorCode(color: ColorBand) usize {
    return @intFromEnum(color);
}

pub fn colors() []const ColorBand {
    return enums.values(ColorBand);
}
