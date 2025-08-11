// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;

    var decimal_value: u32 = 0;
    const len = digits.len;

    for (digits, 0..) |digit, idx| {
        if (digit >= input_base) return ConversionError.InvalidDigit;
        const power = std.math.pow(u32, input_base, @truncate(len - idx - 1));
        decimal_value += digit * power;
    }

    var result = std.ArrayList(u32).init(allocator);
    defer result.deinit();

    if (len == 0 or decimal_value == 0) {
        try result.append(0);
    } else {
        while (decimal_value > 0) : (decimal_value /= output_base) {
            try result.insert(0, decimal_value % output_base);
        }
    }

    return result.toOwnedSlice();
}
