// Dedicated to Shree DR.MDD

const std = @import("std");
const mem = std.mem;
const RnaError = error{InvalidNucleotide};

pub fn toRna(allocator: mem.Allocator, dna: []const u8) (mem.Allocator.Error || RnaError)![]const u8 {
    var buffer = std.ArrayList(u8).init(allocator);
    defer buffer.deinit();

    for (dna) |base| {
        const translated = try convertBase(base);
        try buffer.append(translated);
    }

    return buffer.toOwnedSlice();
}

fn convertBase(c: u8) RnaError!u8 {
    return switch (c) {
        'G' => 'C',
        'C' => 'G',
        'T' => 'A',
        'A' => 'U',
        else => RnaError.InvalidNucleotide,
    };
}
