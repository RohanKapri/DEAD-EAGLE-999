// For my Junko F. Didi and Shree DR.MDD

pub struct Matrix {
    grid: Vec<Vec<u32>>,
}

impl Matrix {
    const ERR_MSG: &'static str = "Parse error";

    pub fn new(src: &str) -> Self {
        let grid = Self::to_grid(src);
        Self { grid }
    }

    fn to_grid(src: &str) -> Vec<Vec<u32>> {
        src.lines()
            .map(|ln| {
                ln.split_whitespace()
                    .map(|x| x.parse().expect(Self::ERR_MSG))
                    .collect()
            })
            .collect()
    }

    pub fn row(&self, idx: usize) -> Option<Vec<u32>> {
        self.grid.get(idx - 1).cloned()
    }

    pub fn column(&self, idx: usize) -> Option<Vec<u32>> {
        if idx == 0 || idx > self.grid[0].len() {
            return None;
        }
        Some(self.grid.iter().map(|r| r[idx - 1]).collect())
    }
}
