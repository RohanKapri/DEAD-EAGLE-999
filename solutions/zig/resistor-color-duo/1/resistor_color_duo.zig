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

pub fn colorCode(colors: [2]ColorBand) usize {
    return toInt(colors[0]) * 10 + toInt(colors[1]);
}

fn toInt(color: ColorBand) usize {
    return @intFromEnum(color);
}