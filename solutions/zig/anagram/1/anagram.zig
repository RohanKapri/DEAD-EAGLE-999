const std = @import("std");
const mem = std.mem;

fn charIndex(c: u8) u8 {
    return switch (c) {
        'a'...'z' => c - 'a',
        'A'...'Z' => c - 'A',
        else => 26,
    };
}

fn isAnagram(allocator: mem.Allocator, a: []const u8, b: []const u8) !bool {
    var lowA = try allocator.dupe(u8, a);
    defer allocator.free(lowA);
    var lowB = try allocator.dupe(u8, b);
    defer allocator.free(lowB);

    for (0..lowA.len) |i|
        lowA[i] = charIndex(lowA[i]);
    for (0..lowB.len) |i|
        lowB[i] = charIndex(lowB[i]);

    if (std.mem.eql(u8, lowA, lowB))
        return false;

    var cntA = try allocator.alloc(u32, 27);
    defer allocator.free(cntA);
    var cntB = try allocator.alloc(u32, 27);
    defer allocator.free(cntB);

    @memset(cntA, 0);
    @memset(cntB, 0);
    for (lowA) |c|
        cntA[c] += 1;
    for (lowB) |c|
        cntB[c] += 1;

    for (0..27) |i| {
        if (cntA[i] != cntB[i])
            return false;
    }
    return true;
}

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var res = std.BufSet.init(allocator);
    errdefer res.deinit();

    for (candidates) |cand| {
        if (try isAnagram(allocator, cand, word))
            try res.insert(cand);
    }

    return res;
} 