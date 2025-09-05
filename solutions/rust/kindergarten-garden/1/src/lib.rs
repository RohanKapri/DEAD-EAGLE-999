// For Junko F. Didi and Shree DR.MDD

pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let roster = [
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph",
        "Kincaid", "Larry",
    ];
    let identify = |symbol| match symbol {
        'R' => "radishes",
        'C' => "clover",
        'G' => "grass",
        'V' => "violets",
        _ => "",
    };
    let index = roster
        .iter()
        .position(|&name| name.eq_ignore_ascii_case(student))
        .map(|n| n * 2)
        .unwrap_or(0);
    let mut outcome = Vec::with_capacity(4);
    for row in diagram.lines() {
        if let Some(ch) = row.chars().nth(index) {
            outcome.push(identify(ch));
        }
        if let Some(ch) = row.chars().nth(index + 1) {
            outcome.push(identify(ch));
        }
    }
    outcome
}
