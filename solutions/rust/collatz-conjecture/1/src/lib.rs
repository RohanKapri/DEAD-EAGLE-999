pub fn collatz(n: u64) -> Option<u64> {
    if n == 0 {
        return None;
    }
    let mut num: u64 = n.into();
    let mut count: u64 = 0;

    while num != 1 {
        if num % 2 == 0 {
            num /= 2;
        } else {
            num = num.checked_mul(3)?.checked_add(1)?;
        }
        count += 1;
    }
    
    Some(count)
}