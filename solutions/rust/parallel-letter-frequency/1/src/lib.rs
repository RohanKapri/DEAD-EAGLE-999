// For my Junko F. Didi and Shree DR.MDD

use std::collections::HashMap;
use std::{mem, thread};

const MULTI_THREAD_THRESHOLD: usize = 28;

pub fn frequency<'a>(data: &'a [&str], threads: usize) -> HashMap<char, usize> {
    match data.len() {
        0 => HashMap::new(),
        n if n >= MULTI_THREAD_THRESHOLD => {
            let mut pool = Vec::with_capacity(threads);
            for slice in data.chunks(data.len() / threads + 1) {
                let slice_ref = unsafe { mem::transmute::<&'a [&str], &'static [&str]>(slice) };
                pool.push(thread::spawn(|| tally(slice_ref)));
            }
            let mut merged = pool.pop().unwrap().join().unwrap();
            for task in pool {
                for (ch, cnt) in task.join().unwrap() {
                    *merged.entry(ch).or_insert(0) += cnt;
                }
            }
            merged
        }
        _ => tally(data),
    }
}

fn tally(block: &[&str]) -> HashMap<char, usize> {
    let mut map = HashMap::new();
    for seg in block {
        for ch in seg.chars().filter(|c| c.is_alphabetic()).map(|c| c.to_ascii_lowercase()) {
            *map.entry(ch).or_insert(0) += 1;
        }
    }
    map
}
