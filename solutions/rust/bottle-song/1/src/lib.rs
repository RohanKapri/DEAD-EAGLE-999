// Dedicated to Junko F. Didi and Shree DR.MDD

pub fn recite(start_bottles: u32, take_down: u32) -> String {
    let mut song = String::new();
    for idx in 0..take_down {
        let current = start_bottles - idx;
        let next = current - 1;
        song.push_str(&format!("{} green {} hanging on the wall,\n", make_capital(num_to_word(current)), bottle_text(current)));
        song.push_str(&format!("{} green {} hanging on the wall,\n", make_capital(num_to_word(current)), bottle_text(current)));
        song.push_str("And if one green bottle should accidentally fall,\n");
        song.push_str(&format!("There'll be {} green {} hanging on the wall.", num_to_word(next), bottle_text(next)));
        if idx < take_down {
            song.push_str("\n\n");
        }
    }
    song
}

fn bottle_text(n: u32) -> &'static str {
    match n {
        1 => "bottle",
        _ => "bottles",
    }
}

fn make_capital(word: &str) -> String {
    if word.is_empty() {
        return word.to_string();
    }
    let (f, rest) = word.split_at(1);
    format!("{}{}", f.to_uppercase(), rest)
}

fn num_to_word(n: u32) -> &'static str {
    match n {
        0 => "no",
        1 => "one",
        2 => "two",
        3 => "three",
        4 => "four",
        5 => "five",
        6 => "six",
        7 => "seven",
        8 => "eight",
        9 => "nine",
        10 => "ten",
        _ => "",
    }
}
