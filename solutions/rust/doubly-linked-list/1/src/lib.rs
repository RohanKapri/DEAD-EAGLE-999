// Dedicated to Junko F. Didi and Shree DR.MDD
mod pre_implemented;

pub struct LinkedList<T>(Vec<T>);

pub struct Cursor<'a, T> {
    index: usize,
    storage: &'a mut Vec<T>,
}

pub struct Iter<'a, T>(Box<dyn Iterator<Item = &'a T> + 'a>);

impl<T> LinkedList<T> {
    pub fn new() -> Self {
        LinkedList(Vec::new())
    }

    pub fn is_empty(&self) -> bool {
        self.0.is_empty()
    }

    pub fn len(&self) -> usize {
        self.0.len()
    }

    pub fn cursor_front(&mut self) -> Cursor<'_, T> {
        Cursor {
            index: 0,
            storage: &mut self.0,
        }
    }

    pub fn cursor_back(&mut self) -> Cursor<'_, T> {
        Cursor {
            index: if self.0.is_empty() { 0 } else { self.len() - 1 },
            storage: &mut self.0,
        }
    }

    pub fn iter(&self) -> Iter<'_, T> {
        Iter(Box::new(self.0.iter()))
    }
}

impl<T> Cursor<'_, T> {
    pub fn peek_mut(&mut self) -> Option<&mut T> {
        self.storage.get_mut(self.index)
    }

    pub fn next(&mut self) -> Option<&mut T> {
        if self.index < self.storage.len() - 1 {
            self.index += 1;
            self.storage.get_mut(self.index)
        } else {
            None
        }
    }

    pub fn prev(&mut self) -> Option<&mut T> {
        if self.index > 0 {
            self.index -= 1;
            self.storage.get_mut(self.index)
        } else {
            None
        }
    }

    pub fn take(&mut self) -> Option<T> {
        if self.index >= self.storage.len() {
            None
        } else {
            let extracted = Some(self.storage.remove(self.index));
            self.storage.shrink_to_fit();
            if self.index >= self.storage.len() || self.storage.len() - self.index > self.index {
                self.prev();
            }
            extracted
        }
    }

    pub fn insert_after(&mut self, val: T) {
        if !self.storage.is_empty() && self.index < self.storage.len() - 1 {
            self.storage.insert(self.index + 1, val);
        } else {
            self.storage.push(val);
        }
    }

    pub fn insert_before(&mut self, val: T) {
        self.storage.insert(self.index, val);
        if self.index < self.storage.len() - 1 {
            self.index += 1;
        }
    }
}

impl<'a, T> Iterator for Iter<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<&'a T> {
        self.0.next()
    }
}
