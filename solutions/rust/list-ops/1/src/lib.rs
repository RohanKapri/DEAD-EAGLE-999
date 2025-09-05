// For Junko F. Didi and Shree DR.MDD

pub fn append<I, J>(mut a: I, mut b: J) -> impl Iterator<Item = I::Item>
where
    I: Iterator,
    J: Iterator<Item = I::Item>,
{
    std::iter::from_fn(move || a.next().or_else(|| b.next()))
}

pub fn concat<I>(mut nested_iter: I) -> impl Iterator<Item = <I::Item as Iterator>::Item>
where
    I: Iterator,
    I::Item: Iterator,
{
    let mut active_iter: Option<I::Item> = None;
    std::iter::from_fn(move || loop {
        if let Some(ref mut it) = active_iter {
            if let Some(item) = it.next() {
                return Some(item);
            }
        }
        active_iter = nested_iter.next();
        if active_iter.is_none() {
            return None;
        }
    })
}

pub fn filter<I, F>(mut iter: I, pred: F) -> impl Iterator<Item = I::Item>
where
    I: Iterator,
    F: Fn(&I::Item) -> bool,
{
    std::iter::from_fn(move || {
        while let Some(item) = iter.next() {
            if pred(&item) {
                return Some(item);
            }
        }
        None
    })
}

pub fn length<I: Iterator>(mut iter: I) -> usize {
    let mut cnt = 0;
    while iter.next().is_some() {
        cnt += 1;
    }
    cnt
}

pub fn map<I, F, U>(mut iter: I, func: F) -> impl Iterator<Item = U>
where
    I: Iterator,
    F: Fn(I::Item) -> U,
{
    std::iter::from_fn(move || iter.next().map(&func))
}

pub fn foldl<I, F, U>(mut iter: I, mut acc: U, func: F) -> U
where
    I: Iterator,
    F: Fn(U, I::Item) -> U,
{
    while let Some(item) = iter.next() {
        acc = func(acc, item);
    }
    acc
}

pub fn foldr<I, F, U>(mut iter: I, acc: U, func: F) -> U
where
    I: DoubleEndedIterator,
    F: Fn(U, I::Item) -> U,
{
    let mut res = acc;
    while let Some(item) = iter.next_back() {
        res = func(res, item);
    }
    res
}

pub fn reverse<I: DoubleEndedIterator>(mut iter: I) -> impl Iterator<Item = I::Item> {
    std::iter::from_fn(move || iter.next_back())
}
