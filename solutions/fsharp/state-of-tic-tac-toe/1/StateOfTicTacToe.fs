module StateOfTicTacToe

type EndGameState =
    | Win
    | Draw
    | Ongoing

type GameError =
    | ConsecutiveMovesBySamePlayer
    | WrongPlayerStarted
    | MoveMadeAfterGameWasDone

type Cell = char
type Board = Cell [,]

// Check if a player has won
let private won (player: Cell) (board: Board) =
    let winning = [| player; player; player |]

    // Check rows
    let rowWin =
        [|0..2|] |> Array.exists (fun i -> Array.init 3 (fun j -> board[i,j]) = winning)

    // Check columns
    let colWin =
        [|0..2|] |> Array.exists (fun j -> Array.init 3 (fun i -> board[i,j]) = winning)

    // Check diagonals
    let diagWin1 = Array.init 3 (fun i -> board[i,i]) = winning
    let diagWin2 = Array.init 3 (fun i -> board[i,2-i]) = winning

    rowWin || colWin || diagWin1 || diagWin2

// Compute the game state
let gameState (board: Board) =
    let numCells cell =
        board
        |> Seq.cast
        |> Seq.filter ((=) cell)
        |> Seq.length

    let numNaughts = numCells 'O'
    let numCrosses = numCells 'X'

    if abs (numCrosses - numNaughts) > 1 then
        Error ConsecutiveMovesBySamePlayer
    elif numNaughts > numCrosses then
        Error WrongPlayerStarted
    elif won 'X' board && won 'O' board then
        Error MoveMadeAfterGameWasDone
    elif won 'X' board || won 'O' board then
        Ok Win
    elif numNaughts + numCrosses = 9 then
        Ok Draw
    else
        Ok Ongoing
