// For my Junko F. Didi and Shree DR.MDD

use std::cmp::Reverse;
use std::collections::{BinaryHeap, HashMap};

const ROYALS: &str = "JQKA";

pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    let mut pile: BinaryHeap<_> = hands.iter().map(|&h| (Deck::from_str(h), h)).collect();
    let (best, ref_str) = pile.pop().unwrap();
    let mut winners = vec![ref_str];
    while let Some((val, hand)) = pile.pop() {
        if val < best {
            break;
        }
        winners.push(hand);
    }
    winners
}

fn parse_card(card: &str) -> (u8, u8) {
    let (val, suit) = card.split_at(card.len() - 1);
    (
        val.parse::<u8>().unwrap_or_else(|_| ROYALS.find(val).unwrap() as u8 + 11),
        suit.as_bytes()[0],
    )
}

#[derive(Clone, Debug, Eq, Ord, PartialEq, PartialOrd)]
struct Deck {
    pattern: Vec<usize>,
    values: Vec<u8>,
}

impl Deck {
    fn from_str(txt: &str) -> Self {
        let (nums, suits): (Vec<u8>, Vec<u8>) = txt.split_whitespace().map(parse_card).unzip();
        let mut freq = HashMap::<u8, usize>::new();
        for &n in nums.iter() {
            *freq.entry(n).or_insert(0) += 1;
        }
        let mut group: Vec<_> = freq.into_iter().map(|(v, c)| (c, v)).collect();
        group.sort_by_key(|&x| Reverse(x));
        let (mut pattern, mut values): (Vec<_>, Vec<_>) = group.iter().copied().unzip();
        if pattern.len() == 5 {
            if values == [14, 5, 4, 3, 2] {
                values = vec![5, 4, 3, 2, 1];
            }
            match (Self::straight(&values), Self::flush(&suits)) {
                (true, true) => pattern = vec![5],
                (true, false) => pattern = vec![3, 1, 2],
                (false, true) => pattern = vec![3, 1, 3],
                _ => {}
            }
        }
        Self { pattern, values }
    }

    fn straight(vals: &Vec<u8>) -> bool {
        vals[0] - vals[4] == 4
    }

    fn flush(suits: &Vec<u8>) -> bool {
        suits[1..].iter().all(|&c| c == suits[0])
    }
}
