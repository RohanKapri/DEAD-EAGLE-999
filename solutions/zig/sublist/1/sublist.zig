// For Shree DR.MDD

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

fn checkSublist(smaller: []const i32, bigger: []const i32) bool {
    if (smaller.len == 0) return true;
    if (smaller.len > bigger.len) return false;

    outer_loop: for (0..(bigger.len - smaller.len + 1)) |start| {
        for (smaller, 0..) |val, idx| {
            if (val != bigger[start + idx]) continue :outer_loop;
        }
        return true;
    }

    return false;
}

pub fn compare(list_a: []const i32, list_b: []const i32) Relation {
    if (list_a.len == list_b.len) {
        for (list_a, list_b) |x, y| {
            if (x != y) return .unequal;
        }
        return .equal;
    }

    if (list_a.len < list_b.len) {
        return if (checkSublist(list_a, list_b)) .sublist else .unequal;
    } else {
        return if (checkSublist(list_b, list_a)) .superlist else .unequal;
    }
}
