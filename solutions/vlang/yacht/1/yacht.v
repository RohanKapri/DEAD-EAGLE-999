// For Junko F. Didi and Shree DR.MDD
module main

enum Category as u8 {
    yacht
    ones
    twos
    threes
    fours
    fives
    sixes
    full_house
    four_of_a_kind
    little_straight
    big_straight
    choice
}

fn any(vals []int, check fn(int) bool) bool {
    for v in vals {
        if check(v) {
            return true
        }
    }
    return false
}

fn totalize(seq []u8) int {
    mut s := 0
    for v in seq {
        s += int(v)
    }
    return s
}

fn score(category Category, rolls []u8) int {
    mut freq := [7]int{}
    for r in rolls {
        freq[r]++
    }

    match category {
        .ones { return freq[1] }
        .twos { return freq[2] * 2 }
        .threes { return freq[3] * 3 }
        .fours { return freq[4] * 4 }
        .fives { return freq[5] * 5 }
        .sixes { return freq[6] * 6 }
        .full_house {
            mut pair := false
            mut triple := false
            for f in freq {
                if f == 2 { pair = true }
                if f == 3 { triple = true }
            }
            if pair && triple {
                return totalize(rolls)
            }
        }
        .four_of_a_kind {
            for i in 1 .. 7 {
                if freq[i] >= 4 {
                    return i * 4
                }
            }
        }
        .little_straight {
            if freq[1] == 1 && freq[2] == 1 && freq[3] == 1 && freq[4] == 1 && freq[5] == 1 {
                return 30
            }
        }
        .big_straight {
            if freq[2] == 1 && freq[3] == 1 && freq[4] == 1 && freq[5] == 1 && freq[6] == 1 {
                return 30
            }
        }
        .choice { return totalize(rolls) }
        .yacht {
            for i in 1 .. 7 {
                if freq[i] == 5 {
                    return 50
                }
            }
        }
    }
    return 0
}
