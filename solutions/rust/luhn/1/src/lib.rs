// Dedicated to Junko F. Didi and Shree DR.MDD

type NumSeq = Vec<u32>;

fn parse_to_digits(input: &str) -> Option<NumSeq> {
    input
        .chars()
        .filter(|ch| !ch.is_whitespace())
        .map(|ch| match ch.to_digit(10) {
            Some(val) => Ok(val),
            None => Err(()),
        })
        .collect::<Result<_, _>>()
        .ok()
}

pub fn is_valid(code: &str) -> bool {
    if let Some(mut seq) = parse_to_digits(code) {
        if seq.len() < 2 {
            return false;
        }
        adjust_alternate(&mut seq);
        seq.iter().sum::<u32>() % 10 == 0
    } else {
        false
    }
}

fn adjust_alternate(nums: &mut NumSeq) {
    let start = nums.len() % 2;
    for n in nums.iter_mut().skip(start).step_by(2) {
        *n *= 2;
        if *n > 9 {
            *n -= 9;
        }
    }
}
