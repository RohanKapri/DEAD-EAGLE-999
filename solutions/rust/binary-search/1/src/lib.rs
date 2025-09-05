use std::cmp::Ordering::{Equal, Greater, Less};
pub fn find(array: &[i32], key: i32) -> Option<usize> {
    if array == [] {
        return None;
    }
    let mut array = Vec::from(array);
    array.sort();
    let mut low = 0i32;
    let mut high = (array.len() - 1) as i32;
    while low <= high {
        let mid = (low + high) / 2;
        match array[mid as usize].cmp(&key) {
            Equal => return Some(mid as usize),
            Less => low = mid + 1,
            Greater => high = mid - 1,
        }
    }
    None
}