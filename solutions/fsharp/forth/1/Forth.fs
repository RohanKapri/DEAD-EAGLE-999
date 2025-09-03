module Forth

open System

type ExecutionContext = 
    { words: Map<string, string seq>; stack: int list }
    static member Empty = { words = Map.empty; stack = [] }

let lower (s: string) = s.ToLower()

let applyBinaryOp op context =
    match context.stack with
        | x :: y :: rest -> { context with stack = (op y x) :: rest }
        | _ -> failwith "not enough parameters"

let dup context = 
    match context.stack with
        | x :: rest -> { context with stack = x :: x :: rest }
        | _ -> failwith "not enough parameters"

let drop context = 
    match context.stack with
        | _ :: rest -> { context with stack = rest }
        | _ -> failwith "not enough parameters"

let over context = 
    match context.stack with
        | x :: y :: rest -> { context with stack = y :: x :: y :: rest }
        | _ -> failwith "not enough parameters"

let swap context = 
    match context.stack with
        | x :: y :: rest -> { context with stack = y :: x :: rest }
        | _ -> failwith "not enough parameters"

let builtInOperators = Map.ofList [
    ("+", applyBinaryOp (+));
    ("-", applyBinaryOp (-));
    ("*", applyBinaryOp (*));
    ("/", applyBinaryOp (/));
    ("dup", dup);
    ("drop", drop);
    ("over", over);
    ("swap", swap);
    ]

type Token = Number of int | Word of string

let convertToToken (token: string) = 
    match Int32.TryParse(token) with
       | (true, i) -> Number i
       | _ -> Word token

let addUserWord context tokens : ExecutionContext = 
    let rec parseDefinition tokens = 
        match tokens with
        | [";"] -> []
        | _ :: [] -> failwith "word definition should end with ;"
        | x :: xs -> (lower x) :: (parseDefinition xs)
        | _ -> failwith "invalid word definition"

    match tokens with
    | x :: definitionTokens ->
        let word = x |> lower |> convertToToken
        match word with
        | Number _ -> failwith "Cannot redefine numbers"
        | Word w ->
            let getDefinition tokenStr = 
                let asToken = convertToToken tokenStr
                match asToken with
                | Number i -> Seq.singleton (string i)
                | Word token ->
                    match context.words.TryGetValue(token) with
                    | (true, instructions) -> instructions
                    | _ -> 
                        match builtInOperators.TryGetValue(token) with
                        | (true, _) -> Seq.singleton token
                        | _ -> failwith (sprintf "unknown word %s" w)

            let definition = definitionTokens |> parseDefinition |> Seq.map getDefinition |> Seq.concat
            { context with
                words = context.words |> Map.add w definition
            }
    | _ -> failwith "invalid word definition"

let addNumber context i = { context with stack = i :: context.stack }

let rec processWord context word processCallback =
    let w = word |> lower
    match context.words.TryGetValue(w) with
    | (true, instructions) -> processCallback context instructions
    | _ -> 
        match builtInOperators.TryGetValue(w) with
        | (true, op) -> op context
        | _ -> failwith (sprintf "unknown word %s" w)

let rec processCalculations context tokens : ExecutionContext =
    tokens |> Seq.fold (fun context token -> 
        match convertToToken token with
        | Number i -> addNumber context i
        | Word w -> processWord context w processCalculations
        ) context

let evaluateInstruction (context: ExecutionContext) (line: string) : ExecutionContext = 
    let tokens = line.Split([|' '|], StringSplitOptions.RemoveEmptyEntries) |> List.ofArray
    match tokens with
        | ":" :: rest -> addUserWord context rest
        | _ -> processCalculations context tokens

let evaluate (program: string list) : int list option = 
    try
        let result = program |> List.fold evaluateInstruction ExecutionContext.Empty
        Some (result.stack |> List.rev)
    with
    | _ -> None