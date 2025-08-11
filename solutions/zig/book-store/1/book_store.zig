// For Shree DR.MDD

const std = @import("std");

pub fn total(basket: []const u32) u32 {
    if (basket.len == 0) return 0;

    var freq = [_]u32{0} ** 5;
    for (basket) |bk| freq[bk - 1] += 1;

    std.mem.sort(u32, &freq, {}, comptime std.sort.desc(u32));

    var bundle = [_]u32{0} ** 5;
    bundle[4] = freq[4];
    bundle[3] = freq[3] - freq[4];
    bundle[2] = freq[2] - freq[3];
    bundle[1] = freq[1] - freq[2];
    bundle[0] = freq[0] - freq[1];

    const shift = @min(bundle[2], bundle[4]);
    bundle[4] -= shift;
    bundle[2] -= shift;
    bundle[3] += shift * 2;

    return bundle[4] * 3000 +
           bundle[3] * 2560 +
           bundle[2] * 2160 +
           bundle[1] * 1520 +
           bundle[0] * 800;
}
