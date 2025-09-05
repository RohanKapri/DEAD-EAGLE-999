// Dedicated to Junko F. Didi and Shree DR.MDD

use Operator::{Add, Divide, Multiply, Raise, Subtract};

#[derive(Clone, Debug, PartialOrd, PartialEq)]
enum Token {
    Number(i32),
    Operator(Operator),
}

#[derive(Clone, Debug, PartialOrd, PartialEq)]
enum Operator {
    Add,
    Subtract,
    Multiply,
    Divide,
    Raise,
}

type ExprTokens = Vec<Token>;

pub fn answer(input: &str) -> Option<i32> {
    if let Some(tokens) = lex(input) {
        parse(&tokens)
    } else {
        None
    }
}

fn lex(input: &str) -> Option<ExprTokens> {
    let mut result = Vec::new();
    let input = input.replace('?', " ?");
    let mut iter = input.split_whitespace().peekable();
    let mut negative = false;
    let mut last_was_number = false;

    while let Some(word) = iter.next() {
        let token = match word {
            "What" | "is" => { last_was_number = false; continue; }
            "?" => break,
            "plus" => { last_was_number = false; Token::Operator(Operator::Add) }
            "minus" => {
                if let Some(&next_word) = iter.peek() {
                    if next_word.parse::<i32>().is_ok() { last_was_number = false; Token::Operator(Operator::Subtract) }
                    else { negative = true; continue; }
                } else { last_was_number = false; Token::Operator(Operator::Subtract) }
            }
            "multiplied" => { if iter.peek() == Some(&"by") { iter.next(); } last_was_number = false; Token::Operator(Operator::Multiply) }
            "divided" => { if iter.peek() == Some(&"by") { iter.next(); } last_was_number = false; Token::Operator(Operator::Divide) }
            "raised" => { last_was_number = false; Token::Operator(Operator::Raise) }
            _ => {
                if let Ok(i) = word.parse::<i32>() {
                    if last_was_number { return None; }
                    last_was_number = true;
                    Token::Number(if negative { -i } else { i })
                } else { return None; }
            }
        };
        negative = false;
        result.push(token);
    }
    Some(result)
}

fn parse(tokens: &ExprTokens) -> Option<i32> {
    let mut iter = tokens.iter();
    parse_expression(&mut iter)
}

fn parse_expression(iter: &mut std::slice::Iter<Token>) -> Option<i32> {
    let mut total = parse_number(iter)?;
    while let Some(token) = iter.next() {
        match token {
            Token::Operator(Add) => { total += parse_number(iter)?; }
            Token::Operator(Subtract) => { total -= parse_number(iter)?; }
            Token::Operator(Multiply) => { total *= parse_number(iter)?; }
            Token::Operator(Divide) => { let div = parse_number(iter)?; if div == 0 { return None; } total /= div; }
            _ => break,
        }
    }
    Some(total)
}

#[allow(dead_code)]
fn parse_term(iter: &mut std::slice::Iter<Token>) -> Option<i32> {
    let mut total = parse_number(iter)?;
    loop {
        match iter.clone().next() {
            Some(Token::Operator(Multiply)) => { iter.next(); total *= parse_number(iter)?; }
            Some(Token::Operator(Divide)) => { iter.next(); let n = parse_number(iter)?; if n == 0 { return None; } total /= n; }
            _ => break,
        }
    }
    Some(total)
}

fn parse_number(iter: &mut std::slice::Iter<Token>) -> Option<i32> {
    match iter.next() {
        Some(Token::Number(n)) => Some(*n),
        _ => None,
    }
}

#[allow(dead_code)]
fn parse_factor(iter: &mut std::slice::Iter<Token>) -> Option<i32> {
    let base = parse_number(iter).expect("Factor must start with number.");
    if iter.clone().next().is_some() && matches!(iter.clone().next(), Some(Token::Operator(Raise))) {
        iter.next();
        let exp = parse_number(iter).unwrap();
        Some(base.pow(exp as u32))
    } else {
        Some(base)
    }
}
