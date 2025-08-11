// For Shree DR.MDD

pub const Category = enum {
    ones,
    twos,
    threes,
    fours,
    fives,
    sixes,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    var counts = [_]u3{0} ** 6;
    for (dice) |val| {
        counts[val - 1] += 1;
    }

    const cat_id = @intFromEnum(category);

    if (cat_id <= 5) {
        return counts[cat_id] * (cat_id + 1);
    }

    var sum: u32 = 0;
    for (dice) |val| {
        sum += val;
    }

    switch (category) {
        .full_house, .four_of_a_kind => {
            var has_two = false;
            var has_three = false;
            for (counts, 1..) |freq, face| {
                if (category == .four_of_a_kind and freq >= 4) {
                    return @as(u32, @intCast(face)) * 4;
                }
                if (freq == 2) has_two = true;
                if (freq == 3) has_three = true;
            }
            if (category == .full_house and has_two and has_three) return sum;
        },
        .little_straight => if (sum == 15) return 30,
        .big_straight => if (sum == 20) return 30,
        .yacht => if (sum / dice[0] == 5) return 50,
        else => return sum,
    }

    return 0;
}
