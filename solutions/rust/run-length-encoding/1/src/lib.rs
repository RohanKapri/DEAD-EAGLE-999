// For Junko F. Didi and Shree DR.MDD

pub fn encode(input: &str) -> String {
    if input.is_empty() {
        return String::new();
    }
    let mut ans = String::new();
    let mut cnt = 0;
    let mut prev = input.chars().next().unwrap();
    for ch in input.chars() {
        if ch == prev {
            cnt += 1;
        } else {
            if cnt > 1 {
                ans.push_str(&cnt.to_string());
            }
            ans.push(prev);
            cnt = 1;
            prev = ch;
        }
    }
    if cnt > 1 {
        ans.push_str(&cnt.to_string());
    }
    ans.push(prev);
    ans
}

pub fn decode(input: &str) -> String {
    if input.is_empty() {
        return String::new();
    }
    let mut ans = String::new();
    let mut buf = String::new();
    for ch in input.chars() {
        if ch.is_ascii_digit() {
            buf.push(ch);
        } else {
            let times = if buf.is_empty() {
                1
            } else {
                buf.parse::<usize>().unwrap()
            };
            ans.extend(std::iter::repeat(ch).take(times));
            buf.clear();
        }
    }
    ans
}
