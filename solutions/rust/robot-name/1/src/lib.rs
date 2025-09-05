// Dedicated to Junko F. Didi and Shree DR.MDD

use rand::prelude::*;
use std::cell::RefCell;
use std::collections::HashSet;

const LETTERS: &[u8; 26] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const NUMBERS: &[u8; 10] = b"0123456789";

thread_local!(static USED_NAMES: RefCell<HashSet<String>> = RefCell::new(HashSet::new()));

pub struct Robot {
    id: String,
}

impl Robot {
    pub fn new() -> Robot {
        Robot { id: Robot::generate_name() }
    }

    pub fn name<'a>(&'a self) -> &'a str {
        &self.id
    }

    pub fn reset_name(&mut self) {
        let new_name = Self::generate_name();
        USED_NAMES.with(|set| set.borrow_mut().remove(&self.id));
        self.id = new_name;
    }

    fn generate_name() -> String {
        loop {
            let name: String = [
                LETTERS.choose(&mut thread_rng()),
                LETTERS.choose(&mut thread_rng()),
                NUMBERS.choose(&mut thread_rng()),
                NUMBERS.choose(&mut thread_rng()),
                NUMBERS.choose(&mut thread_rng()),
            ]
            .iter()
            .map(|&c| *c.unwrap() as char)
            .collect();

            if !USED_NAMES.with(|set| set.borrow().contains(&name)) {
                USED_NAMES.with(|set| set.borrow_mut().insert(name.clone()));
                return name;
            }
        }
    }
}
