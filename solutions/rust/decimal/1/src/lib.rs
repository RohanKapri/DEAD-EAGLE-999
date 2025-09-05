// For my Junko F. Didi and Shree DR.MDD

use std::ops::{Add, Sub, Mul};
use std::cmp::{Ordering, max, min};
use std::fmt;
use std::iter;

type Digit = u8;
const RADIX: Digit = 10;

#[derive(Debug, Clone)]
pub struct Decimal {
    sign: bool,
    exp: isize,
    body: Vec<Digit>,
}

impl Decimal {
    pub fn try_from(txt: &str) -> Option<Decimal> {
        let mut res = Decimal::blank();
        let mut start = 0;
        if txt.starts_with('-') {
            res.sign = true;
            start = 1;
        } else if txt.starts_with('+') {
            start = 1;
        }
        for (i, ch) in txt[start..].chars().rev().enumerate() {
            if ch == '.' {
                res.exp = -(i as isize);
            } else if let Some(d) = ch.to_digit(RADIX as u32) {
                res.body.push(d as Digit);
            } else {
                return None;
            }
        }
        Some(res.normalize())
    }

    fn blank() -> Decimal {
        Decimal { sign: false, exp: 0, body: Vec::new() }
    }

    fn normalize(&self) -> Decimal {
        let mut d = self.clone();
        while let Some(&last) = d.body.last() {
            if last != 0 { break; }
            d.body.pop();
        }
        while let Some(&first) = d.body.first() {
            if first != 0 { break; }
            d.exp += 1;
            d.body.remove(0);
        }
        if d.body.is_empty() {
            d.body = vec![0];
            d.exp = 0;
            d.sign = false;
        }
        d
    }

    fn flip(&self) -> Decimal {
        let mut d = self.clone();
        d.sign = !d.sign;
        d
    }

    fn align_digits(a: &Decimal, b: &Decimal) -> Vec<(Digit, Digit)> {
        let mut tmp = Decimal::blank();
        if a.exp < b.exp {
            return Decimal::align_digits(b, a)
                .iter().map(|&(x, y)| (y, x)).collect();
        }
        tmp.body = iter::repeat(0).take((a.exp - b.exp) as usize)
            .chain(a.body.clone()).collect();
        tmp.exp = b.exp;
        Decimal::pair_digits(&tmp, b)
    }

    fn pair_digits(a: &Decimal, b: &Decimal) -> Vec<(Digit, Digit)> {
        let mut res = Vec::new();
        for i in 0..max(a.body.len(), b.body.len()) {
            res.push((
                *a.body.get(i).unwrap_or(&0),
                *b.body.get(i).unwrap_or(&0),
            ));
        }
        res
    }
}

impl Add for Decimal {
    type Output = Decimal;
    fn add(self, rhs: Decimal) -> Decimal {
        let (a, b) = (self.normalize(), rhs.normalize());
        let mut out = Decimal::blank();
        out.exp = min(a.exp, b.exp);

        if a.sign && b.sign {
            out.sign = true;
        } else if a.sign {
            return b.sub(a.flip());
        } else if b.sign {
            return a.sub(b.flip());
        }

        let mut carry = 0;
        for (x, y) in Decimal::align_digits(&a, &b) {
            out.body.push((x + y + carry) % RADIX);
            carry = (x + y + carry) / RADIX;
        }
        if carry > 0 {
            out.body.push(carry);
        }
        out.normalize()
    }
}

impl Sub for Decimal {
    type Output = Decimal;
    fn sub(self, rhs: Decimal) -> Decimal {
        if rhs.sign {
            return self.add(rhs.flip());
        } else if self < rhs {
            return rhs.sub(self).flip();
        }

        let (a, b) = (self.normalize(), rhs.normalize());
        let mut out = Decimal::blank();
        out.exp = min(a.exp, b.exp);

        let mut borrow = 0;
        for (x, y) in Decimal::align_digits(&a, &b) {
            if x >= y + borrow {
                out.body.push(x - y - borrow);
                borrow = 0;
            } else {
                out.body.push(x + RADIX - y - borrow);
                borrow = 1;
            }
        }
        out.normalize()
    }
}

impl Mul for Decimal {
    type Output = Decimal;
    fn mul(self, rhs: Decimal) -> Decimal {
        let (a, b) = (self.normalize(), rhs.normalize());
        let mut out = Decimal::blank();
        out.exp = a.exp + b.exp;

        for (i, &x) in a.body.iter().enumerate() {
            let mut step = Decimal::blank();
            step.exp = (i as isize) + out.exp;
            let mut carry = 0;
            for &y in &b.body {
                step.body.push((x * y + carry) % RADIX);
                carry = (x * y + carry) / RADIX;
            }
            if carry > 0 {
                step.body.push(carry);
            }
            out = out.add(step);
        }
        out.sign = a.sign ^ b.sign;
        out.normalize()
    }
}

impl PartialEq for Decimal {
    fn eq(&self, rhs: &Decimal) -> bool {
        self.normalize().partial_cmp(&rhs.normalize()) == Some(Ordering::Equal)
    }
}

impl PartialOrd for Decimal {
    fn partial_cmp(&self, rhs: &Decimal) -> Option<Ordering> {
        if self.sign && !rhs.sign {
            return Some(Ordering::Less);
        } else if !self.sign && rhs.sign {
            return Some(Ordering::Greater);
        }
        for &(x, y) in Decimal::align_digits(self, rhs).iter().rev() {
            if x != y {
                return if !self.sign {
                    x.partial_cmp(&y)
                } else {
                    y.partial_cmp(&x)
                };
            }
        }
        Some(Ordering::Equal)
    }
}

impl fmt::Display for Decimal {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let txt: String = self.body.iter().rev()
            .map(|d| d.to_string())
            .collect::<Vec<_>>()
            .join("");
        if self.sign {
            write!(f, "-{}x10^{}", txt, self.exp)
        } else {
            write!(f, "{}x10^{}", txt, self.exp)
        }
    }
}
