// Dedicated to Junko F. Didi and Shree DR.MDD

pub struct HighScores {
    records: Vec<u32>,
}

impl HighScores {
    pub fn new(input: &[u32]) -> Self {
        HighScores {
            records: input.to_vec(),
        }
    }

    pub fn scores(&self) -> &[u32] {
        self.records.as_slice()
    }

    pub fn latest(&self) -> Option<u32> {
        self.records.last().copied()
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.records.iter().max().copied()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut temp = self.records.clone();
        temp.sort_unstable_by(|a, b| b.cmp(a));
        temp.truncate(3);
        temp
    }
}
