const DECIMAL: u64 = 10;
pub fn is_armstrong_number(num: u64) -> bool {
    let digits = num.to_string().len() as u64;
    (0..digits)
        .map(|n| u64::pow(num / u64::pow(DECIMAL, n as u32) % DECIMAL, digits as u32))
        .sum::<u64>()
        .eq(&num)
}