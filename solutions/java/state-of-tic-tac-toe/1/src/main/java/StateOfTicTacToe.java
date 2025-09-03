import java.util.Arrays;
class StateOfTicTacToe {
    public GameState determineState(String[] board) {
        char[][] boardArr = Arrays.stream(board).map(s -> s.toCharArray()).toArray(char[][]::new);
        char winner = ' ';
        int xoBalance = 0, emptyCount = 0;
        for (int i = 0; i < 3; i++) {
            char rowTarget = boardArr[i][0];
            if (rowTarget != ' ' && boardArr[i][1] == rowTarget && boardArr[i][2] == rowTarget) winner = validateWin(winner, rowTarget);
            char columnTarget = boardArr[0][i];
            if (columnTarget != ' ' && boardArr[1][i] == columnTarget && boardArr[2][i] == columnTarget) winner = validateWin(winner, columnTarget);
            for (int j = 0; j < 3; j++) {
                char currentChar = boardArr[i][j];
                if (currentChar == 'X') xoBalance++;
                else if (currentChar == 'O') xoBalance--;
                else emptyCount++;
            }
        }
        if (xoBalance > 1) throw new IllegalArgumentException("Wrong turn order: X went twice");
        if (xoBalance < 0) throw new IllegalArgumentException("Wrong turn order: O started");
        char diagonalTarget = boardArr[1][1];
        if (diagonalTarget != ' ' && (boardArr[0][0] == diagonalTarget && boardArr[2][2] == diagonalTarget || boardArr[0][2] == diagonalTarget && boardArr[2][0] == diagonalTarget)) winner = validateWin(winner, diagonalTarget);
        return winner != ' ' ? GameState.WIN : emptyCount == 0 ? GameState.DRAW : GameState.ONGOING;
    }
    private char validateWin(char currentWinner, char newWinner) {
        if (currentWinner != ' ' && newWinner != currentWinner) throw new IllegalArgumentException("Impossible board: game should have ended after the game was won");
        return newWinner;
    }
}
