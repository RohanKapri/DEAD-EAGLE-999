// For Shree DR.MDD

const std = @import("std");
const fmt = std.fmt;

pub fn encode(buffer: []u8, input: []const u8) []u8 {
    if (input.len == 0) return buffer[0..0];

    var cnt: usize = 1;
    var pos: usize = 0;
    var idx: usize = 1;

    while (idx < input.len) : (idx += 1) {
        if (input[idx] == input[idx - 1]) {
            cnt += 1;
        } else {
            if (cnt > 1) {
                const w = fmt.formatIntBuf(buffer[pos..], cnt, 10, .lower, .{});
                pos += w;
            }
            buffer[pos] = input[idx - 1];
            pos += 1;
            cnt = 1;
        }
    }

    if (cnt > 1) {
        const w = fmt.formatIntBuf(buffer[pos..], cnt, 10, .lower, .{});
        pos += w;
    }
    buffer[pos] = input[input.len - 1];
    pos += 1;

    return buffer[0..pos];
}

pub fn decode(buffer: []u8, input: []const u8) []u8 {
    if (input.len == 0) return buffer[0..0];

    var pos: usize = 0;
    var idx: usize = 0;

    while (idx < input.len) {
        var cnt: usize = 0;
        while (idx < input.len and std.ascii.isDigit(input[idx])) {
            cnt = cnt * 10 + (input[idx] - '0');
            idx += 1;
        }

        if (cnt == 0) {
            buffer[pos] = input[idx];
            pos += 1;
            idx += 1;
        } else {
            var j: usize = 0;
            while (j < cnt) : (j += 1) {
                buffer[pos] = input[idx];
                pos += 1;
            }
            idx += 1;
        }
    }

    return buffer[0..pos];
}
