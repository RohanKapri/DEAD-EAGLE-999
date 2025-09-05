pub fn reply(message: &str) -> &str {
    match message.trim() {
        s if s.is_empty() => "Fine. Be that way!",
        s if is_shout(s) && is_question(s) => "Calm down, I know what I'm doing!",
        s if is_question(s) => "Sure.",
        s if is_shout(s) => "Whoa, chill out!",
        _ => "Whatever.",
    }
}
fn is_shout(s: &str) -> bool {
    s.to_uppercase() == s && s.chars().any(|c| c.is_uppercase())
}
fn is_question(s: &str) -> bool {
    s.ends_with('?')
}