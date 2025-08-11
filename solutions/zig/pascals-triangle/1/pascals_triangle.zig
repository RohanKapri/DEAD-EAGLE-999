// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, total: usize) mem.Allocator.Error![][]u128 {
    if (total == 0) {
        return allocator.alloc([]u128, 0);
    }

    var matrix = try allocator.alloc([]u128, total);

    errdefer {
        for (matrix) |line| {
            allocator.free(line);
        }
        allocator.free(matrix);
    }

    matrix[0] = try allocator.alloc(u128, 1);
    matrix[0][0] = 1;

    for (1..total) |idx| {
        const length = idx + 1;
        matrix[idx] = try allocator.alloc(u128, length);

        matrix[idx][0] = 1;
        matrix[idx][length - 1] = 1;

        for (1..length - 1) |pos| {
            matrix[idx][pos] = matrix[idx - 1][pos - 1] + matrix[idx - 1][pos];
        }
    }

    return matrix;
}
