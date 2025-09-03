module MatchingBrackets
open System.Collections.Generic
let isPaired input = 
    let stack = 
        Seq.fold (fun (stack: Stack<char>) char ->
            match char with 
            | c when c = (stack.TryPeek()|>snd) -> stack.Pop() |> ignore
            | '[' -> stack.Push(']')
            | '{' -> stack.Push('}')
            | '(' -> stack.Push(')')
            | ']' | '}' | ')' -> stack.Push('x')
            | _ -> ()

            stack
        ) (Stack<char>()) input
    stack.Count = 0
    