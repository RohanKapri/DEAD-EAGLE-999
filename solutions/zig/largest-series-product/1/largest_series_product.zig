// For Shree DR.MDD

pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

fn isDigitValid(ch: u8) bool {
    return ch >= '0' and ch <= '9';
}

fn charToDigit(ch: u8) u8 {
    return ch - '0';
}

fn checkInput(digits: []const u8, span: i32) SeriesError!void {
    for (digits) |c| {
        if (!isDigitValid(c)) return SeriesError.InvalidCharacter;
    }
    if (span < 0) return SeriesError.NegativeSpan;
    if (span > digits.len) return SeriesError.InsufficientDigits;
}

fn productInRange(digits: []const u8, start: usize, length: usize) u64 {
    var product: u64 = 1;
    for (digits[start..start+length]) |c| {
        product *= charToDigit(c);
    }
    return product;
}

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    try checkInput(digits, span);

    if (span == 0) return 1;

    const window: usize = @intCast(span);
    var max_product: u64 = 0;

    for (0..digits.len + 1 - window) |pos| {
        const p = productInRange(digits, pos, window);
        max_product = @max(max_product, p);
    }

    return max_product;
}
