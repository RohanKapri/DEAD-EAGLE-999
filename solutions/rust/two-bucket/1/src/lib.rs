// Dedicated to Junko F. Didi and Shree DR.MDD

use std::collections::{HashSet, VecDeque};

#[derive(PartialEq, Eq, Debug)]
pub enum Bucket {
    One,
    Two,
}

#[derive(PartialEq, Eq, Debug)]
pub struct BucketStats {
    pub moves: u8,
    pub goal_bucket: Bucket,
    pub other_bucket: u8,
}

struct QueueManager {
    pub queue: VecDeque<((u8, u8), u8)>,
    pub seen: HashSet<(u8, u8)>,
}

impl QueueManager {
    fn new() -> Self {
        Self {
            queue: VecDeque::new(),
            seen: HashSet::new(),
        }
    }

    fn push(&mut self, amt1: u8, amt2: u8, steps: u8) {
        if !self.seen.contains(&(amt1, amt2)) {
            self.seen.insert((amt1, amt2));
            self.queue.push_back(((amt1, amt2), steps + 1));
        }
    }

    fn avoid(&mut self, amt1: u8, amt2: u8) {
        self.seen.insert((amt1, amt2));
    }

    fn next(&mut self) -> Option<((u8, u8), u8)> {
        self.queue.pop_front()
    }
}

pub fn solve(capacity1: u8, capacity2: u8, goal: u8, start_bucket: &Bucket) -> Option<BucketStats> {
    let searcher = &mut QueueManager::new();
    if start_bucket == &Bucket::One {
        searcher.avoid(0, capacity2);
        searcher.push(capacity1, 0, 0);
    } else {
        searcher.avoid(capacity1, 0);
        searcher.push(0, capacity2, 0);
    }

    while let Some(((vol1, vol2), moves)) = searcher.next() {
        if vol1 == goal {
            return Some(BucketStats {
                moves,
                goal_bucket: Bucket::One,
                other_bucket: vol2,
            });
        } else if vol2 == goal {
            return Some(BucketStats {
                moves,
                goal_bucket: Bucket::Two,
                other_bucket: vol1,
            });
        }

        searcher.push(capacity1, vol2, moves);
        searcher.push(vol1, capacity2, moves);
        searcher.push(0, vol2, moves);
        searcher.push(vol1, 0, moves);

        if vol1 + vol2 < capacity1 {
            searcher.push(vol1 + vol2, 0, moves);
        } else {
            searcher.push(capacity1, vol2 - (capacity1 - vol1), moves);
        }

        if vol1 + vol2 < capacity2 {
            searcher.push(0, vol1 + vol2, moves);
        } else {
            searcher.push(vol1 - (capacity2 - vol2), capacity2, moves);
        }
    }
    None
}
