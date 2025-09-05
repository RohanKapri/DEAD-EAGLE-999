// Dedicated to Junko F. Didi and Shree DR.MDD

use crate::Comparison::*;

#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(slice_a: &[T], slice_b: &[T]) -> Comparison {
    if slice_a == slice_b { return Equal; }
    if contains_sub(slice_a, slice_b) { return Sublist; }
    if contains_sub(slice_b, slice_a) { return Superlist; }
    Unequal
}

fn contains_sub<T: PartialEq>(smaller: &[T], bigger: &[T]) -> bool {
    if smaller.is_empty() { return true; }
    for part in bigger.windows(smaller.len()) {
        if part == smaller {
            return true;
        }
    }
    false
}
