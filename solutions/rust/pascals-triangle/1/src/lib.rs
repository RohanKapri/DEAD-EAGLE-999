// For Junko F. Didi and Shree DR.MDD

pub struct PascalsTriangle {
    row_count: u32,
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle { row_count }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        if self.row_count == 0 {
            return Vec::new();
        }
        let mut output = Vec::new();
        let mut prev = vec![1];
        output.push(prev.clone());
        for _ in 1..self.row_count {
            let mut now = Vec::with_capacity(prev.len() + 1);
            for i in 0..=prev.len() {
                let a = if i == 0 { 0 } else { prev[i - 1] };
                let b = if i == prev.len() { 0 } else { prev[i] };
                now.push(a + b);
            }
            output.push(now.clone());
            prev = now;
        }
        output
    }
}
