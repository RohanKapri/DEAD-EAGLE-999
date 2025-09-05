// Dedicated to Junko F. Didi and Shree DR.MDD
type Domino = (u8, u8);

pub fn chain(input: &[Domino]) -> Option<Vec<Domino>> {
    if input.is_empty() {
        return Some(vec![])
    }

    let mut pool = [input.to_vec(), Vec::<Domino>::new()];
    let mut active = 0;
    let mut reserve = 1;
    let mut sequence = Vec::<Domino>::new();

    sequence.push(pool[active].remove(0));
    while !pool[active].is_empty() {
        let mut matched = false;
        for j in 0..pool[active].len() {
            if pool[active][j].0 == sequence.last().unwrap().1 {
                sequence.push(pool[active].remove(j));
                matched = true;
                break;
            } else if pool[active][j].1 == sequence.last().unwrap().1 {
                let picked = pool[active].remove(j);
                sequence.push((picked.1, picked.0));
                matched = true;
                break;
            }
        }
        if !matched { pool[reserve].push(sequence.pop().unwrap()); }
        if sequence.is_empty() { break; }
        if pool[active].is_empty() {
            active = 1 - active;
            reserve = 1 - reserve;
        }
    }

    if sequence.is_empty() || sequence.first().unwrap().0 != sequence.last().unwrap().1 {
        None
    } else {
        Some(sequence)
    }
}
