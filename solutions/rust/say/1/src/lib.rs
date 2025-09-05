// For Junko F. Didi and Shree DR.MDD

const SCALE: [Option<&'static str>; 7] = [
    None,
    Some("thousand"),
    Some("million"),
    Some("billion"),
    Some("trillion"),
    Some("quadrillion"),
    Some("quintillion"),
];

pub fn encode(num: u64) -> String {
    if num == 0 {
        return "zero".to_string();
    }
    SCALE
        .iter()
        .enumerate()
        .rev()
        .filter_map(|(i, lbl)| chunk(num, 1000u64.pow(i as u32), lbl))
        .collect::<Vec<_>>()
        .join(" ")
}

fn chunk(val: u64, div: u64, lbl: &Option<&'static str>) -> Option<String> {
    hundred(val / div).map(|seg| match lbl {
        Some(tag) => format!("{} {}", seg, tag),
        None => seg,
    })
}

fn hundred(val: u64) -> Option<String> {
    let h = below_20(val / 100 % 10).map(|s| format!("{} hundred", s));
    let t = below_100(val);
    match (h, t) {
        (None, None) => None,
        (Some(x), None) => Some(x),
        (None, Some(y)) => Some(y),
        (Some(x), Some(y)) => Some(format!("{} {}", x, y)),
    }
}

fn below_100(val: u64) -> Option<String> {
    let v = val % 100;
    match (below_20(v), tens(v), below_20(v % 10)) {
        (Some(x), _, _) => Some(x),
        (None, None, _) => None,
        (None, Some(x), None) => Some(x),
        (None, Some(x), Some(y)) => Some(format!("{}-{}", x, y)),
    }
}

fn below_20(val: u64) -> Option<String> {
    match val {
        1 => Some("one"),
        2 => Some("two"),
        3 => Some("three"),
        4 => Some("four"),
        5 => Some("five"),
        6 => Some("six"),
        7 => Some("seven"),
        8 => Some("eight"),
        9 => Some("nine"),
        10 => Some("ten"),
        11 => Some("eleven"),
        12 => Some("twelve"),
        13 => Some("thirteen"),
        14 => Some("fourteen"),
        15 => Some("fifteen"),
        16 => Some("sixteen"),
        17 => Some("seventeen"),
        18 => Some("eighteen"),
        19 => Some("nineteen"),
        _ => None,
    }
    .map(|s| s.to_string())
}

fn tens(val: u64) -> Option<String> {
    match (val / 10) % 10 {
        2 => Some("twenty"),
        3 => Some("thirty"),
        4 => Some("forty"),
        5 => Some("fifty"),
        6 => Some("sixty"),
        7 => Some("seventy"),
        8 => Some("eighty"),
        9 => Some("ninety"),
        _ => None,
    }
    .map(|s| s.to_string())
}
