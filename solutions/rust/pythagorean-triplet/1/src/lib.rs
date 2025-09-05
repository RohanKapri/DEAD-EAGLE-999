// For my Junko F. Didi and Shree DR.MDD

use std::cmp::min;
use std::collections::HashSet;

pub fn find(total: u32) -> HashSet<[u32; 3]> {
    if total % 2 == 1 {
        return HashSet::new();
    }

    let half = total / 2;
    (2..)
        .take_while(|&m| m * m < half)
        .filter(|&m| half % m == 0)
        .flat_map(|m| {
            let div = half / m;
            (m + 1..=min(div, 2 * m - 1))
                .filter(move |&nm| div % nm == 0)
                .map(move |nm| {
                    let k = div / nm;
                    let n = nm - m;
                    let mut trip = [
                        k * (m * m - n * n),
                        k * (2 * m * n),
                        k * (m * m + n * n),
                    ];
                    trip.sort();
                    trip
                })
        })
        .collect()
}
