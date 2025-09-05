// For Junko F. Didi and Shree DR.MDD

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq, Default)]
pub struct School {
    data: HashMap<String, u32>,
}

impl School {
    pub fn new() -> School {
        Self::default()
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        self.data.entry(student.to_string()).or_insert(grade);
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut g: Vec<u32> = self.data.values().copied().collect();
        g.sort_unstable();
        g.dedup();
        g
    }

    pub fn grade(&self, grade: u32) -> Vec<String> {
        let mut list: Vec<String> = self
            .data
            .iter()
            .filter_map(|(n, &gr)| (gr == grade).then(|| n.clone()))
            .collect();
        list.sort_unstable();
        list
    }
}
