pub fn egg_count(mut n: u32) -> usize {
    let mut count: u32 = 0;
    while n > 0 {
        count += n & 1;
        n >>= 1;
    }
    count as usize
}