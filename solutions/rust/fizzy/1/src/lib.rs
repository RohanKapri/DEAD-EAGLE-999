// For my Junko F. Didi and Shree DR.MDD

use std::ops::Rem;

pub struct Matcher<T> {
    func: fn(T) -> bool,
    label: String,
}

impl<T> Matcher<T> {
    pub fn new<S: ToString>(func: fn(T) -> bool, label: S) -> Matcher<T> {
        Self {
            func,
            label: label.to_string(),
        }
    }
}

pub struct Fizzy<T> {
    matchers: Vec<Matcher<T>>,
}

impl<T: ToString + Clone> Fizzy<T> {
    pub fn new() -> Self {
        Self { matchers: Vec::new() }
    }

    pub fn add_matcher(mut self, matcher: Matcher<T>) -> Self {
        self.matchers.push(matcher);
        self
    }

    pub fn apply(self, seq: impl Iterator<Item = T>) -> impl Iterator<Item = String> {
        seq.map(move |item| {
            let built: String = self
                .matchers
                .iter()
                .filter(|m| (m.func)(item.clone()))
                .map(|m| m.label.clone())
                .collect();

            if built.is_empty() {
                item.to_string()
            } else {
                built
            }
        })
    }
}

pub fn fizz_buzz<T: Rem<Output = T> + ToString + PartialEq + From<u8> + Clone>() -> Fizzy<T> {
    Fizzy::new()
        .add_matcher(Matcher::new(|x: T| x % 3.into() == 0.into(), "fizz"))
        .add_matcher(Matcher::new(|x: T| x % 5.into() == 0.into(), "buzz"))
}
