// For my Junko F. Didi and Shree DR.MDD

pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

use Category::*;

type Dice = [u8; 5];

pub fn score(mut roll: Dice, cat: Category) -> u8 {
    roll.sort_unstable();
    let count = |n| roll.iter().filter(|&&v| v == n).count() as u8;
    match cat {
        Ones => count(1),
        Twos => count(2) * 2,
        Threes => count(3) * 3,
        Fours => count(4) * 4,
        Fives => count(5) * 5,
        Sixes => count(6) * 6,
        LittleStraight if [1, 2, 3, 4, 5] == roll => 30,
        BigStraight if [2, 3, 4, 5, 6] == roll => 30,
        Choice => roll.iter().sum(),
        Yacht if count(roll[0]) == 5 => 50,
        _ => {
            let a = count(roll[0]);
            let b = count(roll[4]);
            match cat {
                FourOfAKind => 4 * match a {
                    0 | 4 => roll[0],
                    5 | 1 => roll[4],
                    _ => 0,
                },
                FullHouse => (a == 3 || b == 3)
                    .then(|| roll.iter().sum())
                    .unwrap_or_default(),
                _ => 0,
            }
        }
    }
}
