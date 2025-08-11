// For Shree DR.MDD

const std = @import("std");
const mem = std.mem;

pub const Triplet = struct {
    a: usize,
    b: usize,
    c: usize,

    pub fn init(a: usize, b: usize, c: usize) Triplet {
        return Triplet{ .a = a, .b = b, .c = c };
    }
};

pub fn tripletsWithSum(allocator: mem.Allocator, n: usize) mem.Allocator.Error![]Triplet {
    var triples = std.ArrayList(Triplet).init(allocator);
    defer triples.deinit();

    const m_limit = std.math.sqrt(n / 2);
    var m_val: usize = 2;
    while (m_val <= m_limit) : (m_val += 1) {
        var k_val: usize = 1;
        while (k_val < m_val) : (k_val += 1) {
            if ((m_val & 1 == 1 and k_val & 1 == 1) or gcdCheck(m_val, k_val) == false) continue;

            const side1 = m_val * m_val - k_val * k_val;
            const side2 = 2 * m_val * k_val;
            const hypotenuse = m_val * m_val + k_val * k_val;

            const s = side1 + side2 + hypotenuse;
            if (s > n) break;

            var mult: usize = 1;
            while (mult * s <= n) : (mult += 1) {
                if (mult * s == n) {
                    try triples.append(rearrange(mult * side1, mult * side2, mult * hypotenuse));
                }
            }
        }
    }

    mem.sort(Triplet, triples.items, {}, struct {
        fn less(_: void, l: Triplet, r: Triplet) bool {
            if (l.a != r.a) return l.a < r.a;
            if (l.b != r.b) return l.b < r.b;
            return l.c < r.c;
        }
    }.less);

    return triples.toOwnedSlice();
}

fn gcdCalc(x: usize, y: usize) usize {
    return if (y == 0) x else gcdCalc(y, x % y);
}

fn gcdCheck(x: usize, y: usize) bool {
    return gcdCalc(x, y) == 1;
}

fn rearrange(p: usize, q: usize, r: usize) Triplet {
    const mn = @min(@min(p, q), r);
    const mx = @max(@max(p, q), r);
    const midv = p + q + r - mn - mx;
    return Triplet.init(mn, midv, mx);
}
