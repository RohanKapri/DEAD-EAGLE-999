// For Shree DR.MDD

import gleam/int
import gleam/list
import gleam/string

pub type Error {
  SyntaxError
  UnknownOperation
  ImpossibleOperation
}

type Token {
  WhatIs
  Plus
  Minus
  Multiply
  Divide
  Integer(Int)
  Unknown
}

pub fn answer(question: String) -> Result(Int, Error) {
  question
  |> string.replace("?", "")
  |> string.split(" ")
  |> lexer([])
  |> eval(0)
}

fn lexer(words: List(String), acc: List(Token)) -> List(Token) {
  case words {
    [] -> acc
    ["What", "is", ..rest] -> lexer(rest, list.append(acc, [WhatIs]))
    ["plus", ..rest] -> lexer(rest, list.append(acc, [Plus]))
    ["minus", ..rest] -> lexer(rest, list.append(acc, [Minus]))
    ["divided", "by", ..rest] -> lexer(rest, list.append(acc, [Divide]))
    ["multiplied", "by", ..rest] -> lexer(rest, list.append(acc, [Multiply]))
    [w, ..rest] -> 
      case int.parse(w) {
        Ok(n) -> lexer(rest, list.append(acc, [Integer(n)]))
        Error(Nil) -> lexer(rest, list.append(acc, [Unknown]))
      }
  }
}

fn eval(tokens: List(Token), current: Int) -> Result(Int, Error) {
  case tokens {
    [] -> Ok(current)
    [WhatIs, Integer(x), ..rest] -> eval(rest, x)
    [Plus, Integer(x), ..rest] -> eval(rest, current + x)
    [Minus, Integer(x), ..rest] -> eval(rest, current - x)
    [Multiply, Integer(x), ..rest] -> eval(rest, current * x)
    [Divide, Integer(0), ..] -> Error(ImpossibleOperation)
    [Divide, Integer(x), ..rest] -> eval(rest, current / x)
    [Unknown, ..] -> Error(UnknownOperation)
    _ -> Error(SyntaxError)
  }
}
