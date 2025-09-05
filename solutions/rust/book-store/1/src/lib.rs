const COST_ONE: u32 = 800;
const COST_TWO: u32 = 1520;
const COST_THREE: u32 = 2160;
const COST_FOUR: u32 = 2560;
const COST_FIVE: u32 = 3000;
const NUM_BOOKS: usize = 5;
pub fn lowest_price(books: &[u32]) -> u32 {
    let mut frequency = [0; NUM_BOOKS];
    for &x in books {
        frequency[(x - 1) as usize] += 1;
    }
    frequency.sort();
    let mut sets = [0; 5];
    let mut current = 0;
    for idx in 0..NUM_BOOKS {
        sets[idx] = frequency[idx] - current;
        current += sets[idx];
    }
    let min_set = if sets[0] < sets[2] { sets[0] } else { sets[2] };
    COST_ONE * sets[4]
        + COST_TWO * sets[3]
        + COST_THREE * (sets[2] - min_set)
        + COST_FOUR * (sets[1] + min_set * 2)
        + COST_FIVE * (sets[0] - min_set)
}