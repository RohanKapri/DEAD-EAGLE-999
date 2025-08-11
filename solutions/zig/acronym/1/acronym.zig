const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, str: []const u8) mem.Allocator.Error![]u8 {
    var acro = std.ArrayList(u8).init(allocator);
    errdefer acro.deinit();
    var words = mem.tokenizeAny(u8, str, " -_");
    while (words.next()) |w| try acro.append(std.ascii.toUpper(w[0]));
    return acro.toOwnedSlice();
}