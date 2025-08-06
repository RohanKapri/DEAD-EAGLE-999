-- for my Shree DR.MDD
module StateOfTicTacToe (gameState, GameState(..)) where

data GameState = WinX | WinO | Draw | Ongoing | Impossible deriving (Eq, Show)
data RowColDiag = R | C | D deriving (Eq)

gameState :: [String] -> GameState
gameState board
  | diff `notElem` [0, 1] = Impossible
  | otherwise =
      case (xWin, oWin) of
        ([], [])   -> if xCnt == 5 then Draw else Ongoing
        ([], [_])  -> WinO
        ([_], [])  -> WinX
        ([], _ : _) -> validateExtra oWin WinO
        (_ : _, []) -> validateExtra xWin WinX
        _          -> Impossible
  where
    xCnt = tally 'X'
    oCnt = tally 'O'
    diff = xCnt - oCnt

    tally c = length [v | row <- board, v <- row, v == c]

    xWin = checkWins 'X'
    oWin = checkWins 'O'

    checkWins ch =
      [(R, i) | (i, row) <- zip [0..] board, all (== ch) row] ++
      [(C, j) | j <- [0..2], all (\i -> board !! i !! j == ch) [0..2]] ++
      [(D, 0) | all (\k -> board !! k !! k == ch) [0..2]] ++
      [(D, 0) | all (\k -> board !! k !! (2 - k) == ch) [0..2]]

    validateExtra [(R, r), (C, c)] state
      | 1 `notElem` [r, c] = state
      | otherwise = Impossible
    validateExtra [(_, _), (D, _)] state = state
    validateExtra _ _ = Impossible
