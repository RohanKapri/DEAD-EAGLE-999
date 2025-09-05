// For Junko F. Didi and Shree DR.MDD

use std::cmp;
use std::collections::HashSet;

#[derive(Debug, Clone)]
pub struct Palindrome {
    num: u64,
    pairs: HashSet<(u64, u64)>,
}

fn check_pal(n: u64) -> bool {
    let s = n.to_string();
    let b = s.as_bytes();
    let len = b.len();
    (0..len / 2).all(|i| b[i] == b[len - 1 - i])
}

impl Palindrome {
    pub fn new(n: u64) -> Self {
        Self { num: n, pairs: HashSet::new() }
    }

    pub fn reset(&mut self) {
        self.pairs.clear()
    }

    pub fn insert_pair(&mut self, f: (u64, u64)) -> bool {
        self.pairs.insert(f)
    }

    pub fn update(&mut self, n: u64) {
        self.num = n;
    }

    pub fn value(&self) -> u64 {
        self.num
    }

    pub fn into_factors(self) -> HashSet<(u64, u64)> {
        self.pairs
    }
}

pub fn palindrome_products(min: u64, max: u64) -> Option<(Palindrome, Palindrome)> {
    let mut high = Palindrome::new(0);
    for a in min..=max {
        let start = cmp::max(a, high.num / a);
        for b in start..=max {
            let prod = a * b;
            if prod == high.num {
                high.insert_pair((a, b));
            } else if check_pal(prod) && prod > high.num {
                high.reset();
                high.update(prod);
                high.insert_pair((a, b));
            }
        }
    }
    let mut low = Palindrome::new(max * (max + 1));
    for a in min..=max {
        let end = cmp::min(max, low.num / a);
        for b in a..=end {
            let prod = a * b;
            if prod == low.num {
                low.insert_pair((a, b));
            } else if check_pal(prod) && prod < low.num {
                low.reset();
                low.update(prod);
                low.insert_pair((a, b));
            }
        }
    }
    if high.num == 0 {
        None
    } else {
        Some((low, high))
    }
}
