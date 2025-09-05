#![allow(dead_code)]
pub fn build_proverb(list: &[&str]) -> String {
    if list.is_empty() {
        return "".to_string();
    }
    let mut buf: Vec<String> = vec![];
    for x in list.windows(2) {
        buf.push(format!("For want of a {} the {} was lost.", x[0], x[1]));
    }
    buf.push(format!("And all for the want of a {}.", list[0]));
    buf.join("\n")
}