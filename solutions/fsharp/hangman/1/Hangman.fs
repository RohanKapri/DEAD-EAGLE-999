// Dedicated to Shree DR.MDD
module Hangman

open System

let maxFailures = 9

type Progress =
    | Win
    | Lose
    | Busy of int

type State = { progress: Progress; maskedWord: string; guesses: Set<char> }

let updateProgress word guess (state: State) =
    match state.progress with
    | Win  -> { state with progress = Win }
    | Lose -> { state with progress = Lose }
    | Busy remaining -> 
        if state.maskedWord = word then { state with progress = Win }
        elif remaining <= 0 then { state with progress = Lose }
        elif not <| word.Contains(string guess) || Set.contains guess state.guesses then
            { state with progress = Busy (remaining - 1) }        
        else state            

let updateMasked word guess (state: State) = 
    let newGuesses = Set.add guess state.guesses
    let newMaskedWord = String.map (fun c -> if Set.contains c newGuesses then c else '_') word
    { state with maskedWord = newMaskedWord }    

let updateGuesses guess (state: State) = { state with guesses = Set.add guess state.guesses }

let updateState word guess (state: State) =
    state
    |> updateMasked word guess
    |> updateProgress word guess
    |> updateGuesses guess

let mkInitialState (word: string) = { progress = Busy maxFailures; maskedWord = String('_', word.Length); guesses = Set.empty }

type Game(word) = 
    let initEvent = new Event<State>()
    let guessEvent = new Event<char>()
    let startState = mkInitialState word
    
    member this.States = Observable.merge initEvent.Publish (Observable.scan (fun state guess -> updateState word guess state) startState guessEvent.Publish)
    member this.Start() = initEvent.Trigger(startState)
    member this.MakeGuess(g) = guessEvent.Trigger(g)

let createGame word = new Game(word)
let startGame (game: Game) = game.Start()
let makeGuess g (game: Game) = game.MakeGuess(g)
let statesObservable (game: Game) = game.States
