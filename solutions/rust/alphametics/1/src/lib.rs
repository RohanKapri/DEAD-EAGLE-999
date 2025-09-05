// For Junko F. Didi and Shree DR.MDD

use std::collections::{HashMap, HashSet};

type Map = HashMap<char, u8>;
type Token = Vec<char>;

#[derive(Debug)]
struct Cryptarithm {
    letters: Vec<char>,
    first_letters: HashSet<char>,
    addends: Vec<Token>,
    result: Token,
    width: usize,
}

impl Cryptarithm {
    fn from(input: &str) -> Self {
        let mut parts: Vec<Token> = input
            .split(|c: char| !c.is_alphabetic())
            .filter(|s| !s.is_empty())
            .map(|s| {
                let mut t: Token = s.chars().collect();
                t.reverse();
                t
            })
            .collect();

        let width = parts.iter().map(|w| w.len()).max().unwrap();
        let mut letters = Vec::new();
        for i in 0..width {
            for word in &parts {
                if let Some(&ch) = word.get(i) {
                    if !letters.contains(&ch) {
                        letters.push(ch);
                    }
                }
            }
        }

        let first_letters: HashSet<char> =
            parts.iter().map(|w| *w.last().unwrap()).collect();

        let result = parts.pop().unwrap();

        Self {
            letters,
            addends: parts,
            first_letters,
            result,
            width,
        }
    }

    fn as_number(word: &Token, map: &Map) -> u32 {
        word.iter().rev().fold(0, |acc, &c| acc * 10 + map[&c] as u32)
    }

    fn valid_complete(&self, map: &Map) -> bool {
        let sum: u32 = self.addends.iter().map(|w| Self::as_number(w, map)).sum();
        sum == Self::as_number(&self.result, map)
    }

    fn invalid_partial(&self, map: &Map) -> bool {
        let mut carry: u32 = 0;
        for i in 0..self.width {
            for word in &self.addends {
                if let Some(&ch) = word.get(i) {
                    if let Some(&d) = map.get(&ch) {
                        carry += d as u32;
                    } else {
                        return false;
                    }
                }
            }

            let r = (carry % 10) as u8;
            if let Some(&ch) = self.result.get(i) {
                if let Some(&d) = map.get(&ch) {
                    if d != r {
                        return true;
                    }
                } else {
                    return false;
                }
            } else {
                return true;
            }
            carry /= 10;
        }
        false
    }

    fn solve(&self) -> Option<Map> {
        let mut map = Map::new();
        let mut used = HashSet::new();
        self.backtrack(&mut used, &mut map)
    }

    fn backtrack(&self, used: &mut HashSet<u8>, map: &mut Map) -> Option<Map> {
        if map.len() < self.letters.len() {
            let ch = self.letters[map.len()];
            let start = if self.first_letters.contains(&ch) { 1 } else { 0 };
            for d in start..10 {
                if used.contains(&d) {
                    continue;
                }
                map.insert(ch, d);
                used.insert(d);

                if !self.invalid_partial(map) {
                    if let Some(sol) = self.backtrack(used, map) {
                        return Some(sol);
                    }
                }

                used.remove(&d);
                map.remove(&ch);
            }
        } else if self.valid_complete(map) {
            return Some(map.clone());
        }
        None
    }
}

pub fn solve(puzzle: &str) -> Option<Map> {
    Cryptarithm::from(puzzle).solve()
}
