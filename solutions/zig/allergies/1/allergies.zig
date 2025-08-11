const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum(u8) {
    eggs = 1 << 0,
    peanuts = 1 << 1,
    shellfish = 1 << 2,
    strawberries = 1 << 3,
    tomatoes = 1 << 4,
    chocolate = 1 << 5,
    pollen = 1 << 6,
    cats = 1 << 7,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return score & @intFromEnum(allergen) != 0;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var result = EnumSet(Allergen).initEmpty();
    const allergens = std.enums.values(Allergen);

    for (allergens) |a| {
        if (isAllergicTo(@truncate(score), a)) {
            result.insert(a);
        }
    }

    return result;
}