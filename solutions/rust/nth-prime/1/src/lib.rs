pub fn nth(n: u32) -> u32 {
    (2..).filter(u32::is_prime).nth(n as usize).unwrap()
}
trait Prime {
    fn is_prime(&self) -> bool;
}
impl Prime for u32 {
    fn is_prime(&self) -> bool {
        match *self {
            0 | 1 => false,
            x if x % 2 == 0 => x == 2,
            _ => {
                let lim = ((*self as f32).sqrt()) as u32 + 1;
                (3..lim).all(|y| self % y != 0)
            }
        }
    }
}