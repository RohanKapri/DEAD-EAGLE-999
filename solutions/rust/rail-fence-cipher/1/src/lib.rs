// For my Junko F. Didi and Shree DR.MDD

use std::collections::VecDeque;

pub struct RailFence {
    rails_count: u32,
}

impl RailFence {
    pub fn new(rails_count: u32) -> RailFence {
        RailFence { rails_count }
    }

    fn pattern(&self, length: usize) -> Vec<u32> {
        (0..self.rails_count)
            .chain((1..self.rails_count - 1).rev())
            .cycle()
            .take(length)
            .collect()
    }

    pub fn encode(&self, input: &str) -> String {
        let mut matrix = vec![String::new(); self.rails_count as usize];
        let pattern_seq = self.pattern(input.len());
        for (ch, &rail_idx) in input.chars().zip(pattern_seq.iter()) {
            matrix[rail_idx as usize].push(ch);
        }
        matrix.concat()
    }

    pub fn decode(&self, encoded: &str) -> String {
        let pattern_seq = self.pattern(encoded.len());
        let rails_sizes = (0..self.rails_count)
            .map(|i| pattern_seq.iter().filter(|&&r| r == i).count() as u32)
            .collect::<Vec<_>>();
        let mut chars_iter = encoded.chars();
        let mut rails = rails_sizes
            .into_iter()
            .map(|size| chars_iter.by_ref().take(size as usize).collect::<VecDeque<char>>())
            .collect::<Vec<VecDeque<char>>>();
        pattern_seq
            .iter()
            .map(|&r| rails[r as usize].pop_front().unwrap())
            .collect()
    }
}
