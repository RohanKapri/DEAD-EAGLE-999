//
// This is only a SKELETON file for the 'Queen Attack' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class QueenAttack {
  constructor(pos = {}) {
    this.black = [0, 3]
    this.white = [7, 3]
    if (pos.black) {
      this.black = pos.black
    }
    if (pos.white) {
      this.white = pos.white
    }
    if(this.black[0] < 0 || this.white[0] < 0 || this.black[1] < 0 || this.white[1] < 0
      || this.black[0] > 7 || this.white[0] > 7 || this.black[1] > 7 || this.white[1] > 7){
        throw new Error("Queen must be placed on the board");
    }
    if(this.white[0] === this.black[0] && this.white[1] === this.black[1]){
      throw new Error('Queens cannot share the same space');
     }
  }

  toString() {
    let board = new Array(8).fill('_ _ _ _ _ _ _ _');
    board[this.white[0]]= board[this.white[0]].substring(0, this.white[1] * 2) + 'W' + board[this.white[0]].substring(this.white[1] * 2+1);
    board[this.black[0]]= board[this.black[0]].substring(0, this.black[1] * 2) + 'B' + board[this.black[0]].substring(this.black[1] * 2+1);    
   return board.join('\n');
  }

  get canAttack() {
    return Math.abs(this.white[0]-this.black[0]) === Math.abs(this.black[1]-this.white[1]) || this.white[0] === this.black[0] || this.white[1] === this.black[1];
  }
}