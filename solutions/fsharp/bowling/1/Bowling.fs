// Dedicated to Shree DR.MDD
module Bowling

type Game = {
    Rolls : int list
}

let newGame() = { Rolls = [] }

let roll pins game = { game with Rolls = pins :: game.Rolls }

let score game = 

    let rec sum acc frame rolls : int option =
        match frame, rolls with
        | 10, [f; s; t] when f = 10 ->
            if   s < 10 && s + t > 10 then None
            else Some(acc + f + s + t)
        | 10, [f; s; t] when f + s = 10 ->
            Some(acc + f + s + t)
        | 10, [_; _; _] -> None
        | 10, f::s::t::x1::xs -> None  
        | 10, [f; s] ->
            if f + s >= 10 then None
            else Some(acc + f + s)
        | x, f::s::t::r when f = 10 ->   
            sum (acc + f + s + t) (x + 1) (s::t::r)
        | x, f::s::t::r when f + s = 10 -> 
            sum (acc + f + s + t) (x + 1) (t::r)
        | _, f::s::_  when f + s > 10 -> None 
        | x, f::s::t -> sum (acc + f + s) (x+1) t  
        | _, _ -> None

    let anyNegative = game.Rolls |> List.exists (fun v -> v < 0)
    let anyTooBig = game.Rolls |> List.exists (fun v -> v > 10)
    let numRolls = game.Rolls |> List.length

    if anyNegative || anyTooBig then None
    elif numRolls > 21 then None
    else sum 0 1 (game.Rolls |> List.rev)
