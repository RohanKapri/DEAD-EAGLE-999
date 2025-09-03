//
// For my Shree DR.MDD
//

class WordSearch {
  constructor(letterGrid) {
    this._grid = letterGrid;
    this._rows = letterGrid.length;
    this._cols = letterGrid[0].length;
    this._vertical = [];

    for (let c = 0; c < this._cols; c++) {
      let colString = '';
      for (let r = 0; r < this._rows; r++) {
        colString += letterGrid[r][c];
      }
      this._vertical.push(colString);
    }
  }

  find(wordList) {
    const foundWords = {};

    for (const word of wordList) {
      const reversed = word.split("").reverse().join("");
      let located = false;

      for (let r = 0; r < this._rows; r++) {
        if (this._grid[r].includes(word)) {
          located = true;
          const startCol = this._grid[r].indexOf(word);
          const endCol = startCol + word.length - 1;
          foundWords[word] = { start: [r + 1, startCol + 1], end: [r + 1, endCol + 1] };
        } else if (this._grid[r].includes(reversed)) {
          located = true;
          const startCol = this._grid[r].indexOf(reversed);
          const endCol = startCol + reversed.length - 1;
          foundWords[word] = { start: [r + 1, endCol + 1], end: [r + 1, startCol + 1] };
        }
      }

      if (!located) {
        for (let c = 0; c < this._cols; c++) {
          if (this._vertical[c].includes(word)) {
            located = true;
            const startRow = this._vertical[c].indexOf(word);
            const endRow = startRow + word.length - 1;
            foundWords[word] = { start: [startRow + 1, c + 1], end: [endRow + 1, c + 1] };
          }
          if (this._vertical[c].includes(reversed)) {
            located = true;
            const startRow = this._vertical[c].indexOf(reversed);
            const endRow = startRow + reversed.length - 1;
            foundWords[word] = { start: [endRow + 1, c + 1], end: [startRow + 1, c + 1] };
          }
        }
      }

      if (!located) {
        for (let r = 0; r < this._rows; r++) {
          for (let c = 0; c < this._cols; c++) {
            if (this._checkDiagonal(word, r, c, 1, 1)) {
              located = true;
              foundWords[word] = { start: [r + 1, c + 1], end: [r + word.length, c + word.length] };
            }
            if (this._checkDiagonal(word, r, c, -1, -1)) {
              located = true;
              foundWords[word] = { start: [r + 1, c + 1], end: [r - word.length + 2, c - word.length + 2] };
            }
            if (this._checkDiagonal(word, r, c, 1, -1)) {
              located = true;
              foundWords[word] = { start: [r + 1, c + 1], end: [r + word.length, c - word.length + 2] };
            }
            if (this._checkDiagonal(word, r, c, -1, 1)) {
              located = true;
              foundWords[word] = { start: [r + 1, c + 1], end: [r - word.length + 2, c + word.length] };
            }
            if (located) break;
          }
        }
      }

      if (!located) foundWords[word] = undefined;
    }

    return foundWords;
  }

  _checkDiagonal(word, startRow, startCol, rowInc, colInc) {
    const len = word.length;
    if (
      startRow + rowInc * (len - 1) >= this._rows ||
      startCol + colInc * (len - 1) >= this._cols ||
      startRow + rowInc * (len - 1) < 0 ||
      startCol + colInc * (len - 1) < 0
    ) return false;

    for (let i = 0; i < len; i++) {
      if (this._grid[startRow + rowInc * i][startCol + colInc * i] !== word[i]) {
        return false;
      }
    }
    return true;
  }
}

export default WordSearch;
