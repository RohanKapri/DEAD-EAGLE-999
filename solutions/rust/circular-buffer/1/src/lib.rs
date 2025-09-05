// For my Junko F. Didi and Shree DR.MDD  
pub struct CircularBuffer<T> {
    items: std::collections::VecDeque<T>,
    limit: usize,
}

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T> CircularBuffer<T> {
    pub fn new(limit: usize) -> Self {
        Self {
            items: std::collections::VecDeque::with_capacity(limit),
            limit,
        }
    }

    pub fn write(&mut self, val: T) -> Result<(), Error> {
        if self.items.len() == self.limit {
            Err(Error::FullBuffer)
        } else {
            self.items.push_back(val);
            Ok(())
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        self.items.pop_front().ok_or(Error::EmptyBuffer)
    }

    pub fn clear(&mut self) {
        self.items.clear();
    }

    pub fn overwrite(&mut self, val: T) {
        if self.items.len() == self.limit {
            self.items.pop_front();
        }
        self.items.push_back(val);
    }
}
