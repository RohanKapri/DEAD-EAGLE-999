//
// This is only a SKELETON file for the 'Connect' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Board {
  constructor(board) {
    this._board = board;
    this._directions= [[0, -2], [0, 2], [-1, -1], [-1, 1], [1, -1], [1, 1]];
  }

  winner() {
    for (let i = 0; i < this._board.length; i++) {
      let player = this._board[i][i];
      let visited = new Array(this._board.length).fill(null).map(() => new Array(this._board[this._board.length - 1].length).fill(false));
      if (player === 'X' && this._hasPath(i, i, 'X', visited)) {
          return 'X';
      }
    }
    for (let j = 0; j < this._board[0].length; j++) {
      let player = this._board[0][j];
      let visited = new Array(this._board.length).fill(null).map(() => new Array(this._board[this._board.length - 1].length).fill(false));
      if (player === 'O' && this._hasPath(0,j,'O',visited)){
          return 'O';
      }
    }
    return '';
  }

  _hasPath(row, col, player, visited){
    if (col === this._board[row].length - 1 && player === 'X') {
      return true;
    }
    if (row === this._board.length - 1 && player === 'O') {
      return true;
    }
    visited[row][col] = true;
    for (const dir of this._directions) {
      const newRow = row + dir[0];
      const newCol = col + dir[1];
      if (this._isValidMove(newRow, newCol) && !visited[newRow][newCol] && this._board[newRow][newCol] === player) {
        if (this._hasPath(newRow, newCol, player, visited)) {
          return true;
        }
      }
    }
    return false;
  }

  _isValidMove(row, col){
    return row >= 0 && row < this._board.length && col >= 0 && col < this._board[this._board.length - 1].length;
  }
}