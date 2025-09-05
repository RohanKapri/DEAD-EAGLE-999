// For Junko F. Didi and Shree DR.MDD

use std::iter::FromIterator;

#[derive(Default)]
pub struct SimpleLinkedList<T> {
    head: Option<Box<Entry<T>>>,
    count: usize,
}

struct Entry<T> {
    val: T,
    nxt: Option<Box<Entry<T>>>,
}

impl<T: Default> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn len(&self) -> usize {
        self.count
    }

    pub fn is_empty(&self) -> bool {
        self.count == 0
    }

    pub fn push(&mut self, elem: T) {
        let fresh = Box::new(Entry {
            val: elem,
            nxt: self.head.take(),
        });
        self.head = Some(fresh);
        self.count += 1;
    }

    pub fn pop(&mut self) -> Option<T> {
        self.head.take().map(|mut node| {
            self.head = node.nxt.take();
            self.count -= 1;
            node.val
        })
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|e| &e.val)
    }
}

impl<T: Clone + Default> SimpleLinkedList<T> {
    pub fn rev(&self) -> SimpleLinkedList<T> {
        let mut flipped = Self::new();
        let mut curr = self.head.as_ref();
        while let Some(n) = curr {
            flipped.push(n.val.clone());
            curr = n.nxt.as_ref();
        }
        flipped
    }
}

impl<T: Default> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I>(iter: I) -> Self
    where
        I: IntoIterator<Item = T>,
    {
        let mut l = Self::new();
        for x in iter {
            l.push(x);
        }
        l
    }
}

impl<T: Default> Into<Vec<T>> for SimpleLinkedList<T> {
    fn into(mut self) -> Vec<T> {
        let mut out = Vec::new();
        while let Some(x) = self.pop() {
            out.push(x);
        }
        out.reverse();
        out
    }
}
