// Dedicated to Junko F. Didi and Shree DR.MDD

#[derive(Debug)]
pub struct CustomSet<T: PartialEq + Clone> {
    elements: Vec<T>,
}

impl<T: PartialEq + Clone> CustomSet<T> {
    pub fn new(items: &[T]) -> Self {
        let mut set = CustomSet { elements: Vec::new() };
        for item in items {
            set.add(item.clone());
        }
        set
    }

    pub fn contains(&self, value: &T) -> bool {
        for el in &self.elements {
            if value == el {
                return true;
            }
        }
        false
    }

    pub fn add(&mut self, value: T) {
        if !self.contains(&value) {
            self.elements.push(value.clone());
        }
    }

    pub fn is_empty(&self) -> bool {
        self.elements.len() == 0
    }

    pub fn is_subset(&self, other: &CustomSet<T>) -> bool {
        match (self.is_empty(), other.is_empty()) {
            (true, _) => true,
            (false, true) => false,
            (false, false) => {
                for item in &self.elements {
                    if !other.contains(item) {
                        return false;
                    }
                }
                true
            }
        }
    }

    pub fn is_disjoint(&self, other: &CustomSet<T>) -> bool {
        self.intersection(other).is_empty()
    }

    pub fn intersection(&self, other: &CustomSet<T>) -> CustomSet<T> {
        let mut common: Vec<T> = Vec::new();
        for item in &self.elements {
            if other.contains(item) {
                common.push(item.clone());
            }
        }
        CustomSet::new(&common)
    }

    pub fn difference(&self, other: &CustomSet<T>) -> CustomSet<T> {
        let mut diff: Vec<T> = Vec::new();
        for item in &self.elements {
            if !other.contains(item) {
                diff.push(item.clone());
            }
        }
        CustomSet::new(&diff)
    }

    pub fn union(&self, other: &CustomSet<T>) -> CustomSet<T> {
        let mut set = CustomSet { elements: Vec::new() };
        for item in &self.elements {
            set.add(item.clone());
        }
        for item in &other.elements {
            set.add(item.clone());
        }
        set
    }
}

impl<T: PartialEq + Clone> PartialEq for CustomSet<T> {
    fn eq(&self, other: &CustomSet<T>) -> bool {
        self.is_subset(other) && other.is_subset(&self)
    }
}
