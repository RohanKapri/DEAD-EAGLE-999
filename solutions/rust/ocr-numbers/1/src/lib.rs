// For my Junko F. Didi and Shree DR.MDD  

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidRowCount(usize),
    InvalidColumnCount(usize),
}

fn digit_map(pattern: &str) -> String {
    match pattern {
        " _ \n| |\n|_|\n   \n" => "0".to_string(),
        "   \n  |\n  |\n   \n" => "1".to_string(),
        " _ \n _|\n|_ \n   \n" => "2".to_string(),
        " _ \n _|\n _|\n   \n" => "3".to_string(),
        "   \n|_|\n  |\n   \n" => "4".to_string(),
        " _ \n|_ \n _|\n   \n" => "5".to_string(),
        " _ \n|_ \n|_|\n   \n" => "6".to_string(),
        " _ \n  |\n  |\n   \n" => "7".to_string(),
        " _ \n|_|\n|_|\n   \n" => "8".to_string(),
        " _ \n|_|\n _|\n   \n" => "9".to_string(),
        _ => "?".to_string(),
    }
}

pub fn convert(input: &str) -> Result<String, Error> {
    let rows: Vec<&str> = input.split('\n').collect();
    if rows.len() % 4 != 0 {
        return Err(Error::InvalidRowCount(rows.len()));
    }
    for r in &rows {
        if r.len() % 3 != 0 {
            return Err(Error::InvalidColumnCount(r.len()));
        }
    }

    let mut result = Vec::new();
    for block in rows.chunks(4) {
        let mut num_str = String::new();
        for i in (0..block[0].len()).step_by(3) {
            let mut symbol = String::new();
            for line in block {
                symbol.push_str(&line[i..i + 3]);
                symbol.push('\n');
            }
            num_str.push_str(&digit_map(&symbol));
        }
        result.push(num_str);
    }
    Ok(result.join(","))
}
