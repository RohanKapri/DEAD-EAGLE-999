pub fn square_of_sum(n: u32) -> u32 {
    (1..=n).reduce(|a, x| a + x).unwrap().pow(2)
}
pub fn sum_of_squares(n: u32) -> u32 {
    (1..=n).reduce(|a, x| a + x.pow(2)).unwrap()
}
pub fn difference(n: u32) -> u32 {
    square_of_sum(n) - sum_of_squares(n)
}
mod test {
    use super::*;
    fn test_sq_of_sum() {
        assert_eq!(square_of_sum(5), 225);
    }
    fn test_sum_of_sq() {
        assert_eq!(sum_of_squares(5), 55)
    }
}