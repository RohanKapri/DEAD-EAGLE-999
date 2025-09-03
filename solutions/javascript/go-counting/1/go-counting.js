// For my Shree DR.MDD

export class GoCounting {
  constructor(boardMatrix) {
    this.blackTerritory = [];
    this.whiteTerritory = [];
    this.noTerritory = [];
    this.stones = [];

    if (!boardMatrix.toString().includes("B") && !boardMatrix.toString().includes("W")) {
      boardMatrix.forEach((row, rowIndex) => {
        for (let colIndex = 0; colIndex < row.length; colIndex++) {
          this.noTerritory.push([colIndex, rowIndex]);
        }
      });
    }

    const markNoTerritory = (x, y) => {
      boardMatrix[y] = boardMatrix[y].slice(0, x) + "x" + boardMatrix[y].slice(x + 1);
      this.noTerritory.push([x, y]);
      if (x > 0 && boardMatrix[y][x - 1] === " ") markNoTerritory(x - 1, y);
      if (x < boardMatrix[y].length - 1 && boardMatrix[y][x + 1] === " ") markNoTerritory(x + 1, y);
      if (y > 0 && boardMatrix[y - 1][x] === " ") markNoTerritory(x, y - 1);
      if (y < boardMatrix.length - 1 && boardMatrix[y + 1][x] === " ") markNoTerritory(x, y + 1);
    };

    const markBlackTerritory = (x, y) => {
      this.blackTerritory.push([x, y]);
      boardMatrix[y] = boardMatrix[y].slice(0, x) + "b" + boardMatrix[y].slice(x + 1);
      if (x > 0 && boardMatrix[y][x - 1] === " ") markBlackTerritory(x - 1, y);
      if (x < boardMatrix[y].length - 1 && boardMatrix[y][x + 1] === " ") markBlackTerritory(x + 1, y);
      if (y > 0 && boardMatrix[y - 1][x] === " ") markBlackTerritory(x, y - 1);
      if (y < boardMatrix.length - 1 && boardMatrix[y + 1][x] === " ") markBlackTerritory(x, y + 1);
    };

    const markWhiteTerritory = (x, y) => {
      this.whiteTerritory.push([x, y]);
      boardMatrix[y] = boardMatrix[y].slice(0, x) + "w" + boardMatrix[y].slice(x + 1);
      if (x > 0 && boardMatrix[y][x - 1] === " ") markWhiteTerritory(x - 1, y);
      if (x < boardMatrix[y].length - 1 && boardMatrix[y][x + 1] === " ") markWhiteTerritory(x + 1, y);
      if (y > 0 && boardMatrix[y - 1][x] === " ") markWhiteTerritory(x, y - 1);
      if (y < boardMatrix.length - 1 && boardMatrix[y + 1][x] === " ") markWhiteTerritory(x, y + 1);
    };

    for (let y = 0; y < boardMatrix.length; y++) {
      for (let x = 0; x < boardMatrix[y].length; x++) {
        let adjacentColor = "";
        const cell = boardMatrix[y][x];
        if (["x", "b", "w"].includes(cell)) continue;
        if (cell === "B" || cell === "W") {
          this.stones.push([x, y]);
          continue;
        }

        if (x > 0) {
          if (boardMatrix[y][x - 1] !== " " && boardMatrix[y][x - 1] !== "x") adjacentColor = boardMatrix[y][x - 1];
          else if (boardMatrix[y][x - 1] === "x") {
            markNoTerritory(x, y);
            continue;
          }
        }

        if (x < boardMatrix[y].length - 1) {
          if (!adjacentColor && boardMatrix[y][x + 1] !== " " && boardMatrix[y][x + 1] !== "x") adjacentColor = boardMatrix[y][x + 1];
          else if (boardMatrix[y][x + 1] === "x") {
            markNoTerritory(x, y);
            continue;
          } else if (adjacentColor && adjacentColor !== boardMatrix[y][x + 1] && boardMatrix[y][x + 1] !== " ") {
            markNoTerritory(x, y);
            continue;
          } else if (boardMatrix[y][x + 1] === " " && this.noTerritory.some(([cx, cy]) => cx === x + 1 && cy === y)) {
            markNoTerritory(x, y);
            continue;
          }
        }

        if (y > 0) {
          if (adjacentColor !== boardMatrix[y - 1][x] && boardMatrix[y - 1][x] !== " ") {
            markNoTerritory(x, y);
            continue;
          } else if (boardMatrix[y - 1][x] === " " && this.noTerritory.some(([cx, cy]) => cx === x && cy === y - 1)) {
            markNoTerritory(x, y);
            continue;
          }
        }

        if (y < boardMatrix.length - 1) {
          if (adjacentColor !== boardMatrix[y + 1][x] && boardMatrix[y + 1][x] !== " ") {
            markNoTerritory(x, y);
            continue;
          } else if (boardMatrix[y + 1][x] === " " && this.noTerritory.some(([cx, cy]) => cx === x && cy === y + 1)) {
            markNoTerritory(x, y);
            continue;
          }
        }

        switch (adjacentColor) {
          case "W":
            markWhiteTerritory(x, y);
            break;
          case "B":
            markBlackTerritory(x, y);
            break;
        }
      }
    }

    this.board = boardMatrix;
  }

  getTerritory(x, y) {
    if (x < 0 || x >= this.board[0].length || y < 0 || y >= this.board.length) {
      return { error: "Invalid coordinate" };
    }

    const output = { owner: "", territory: [] };

    const floodFill = (marker, x, y) => {
      output.territory.push([x, y]);
      this.board[y] = this.board[y].slice(0, x) + "o" + this.board[y].slice(x + 1);
      if (x > 0 && this.board[y][x - 1] === marker) floodFill(marker, x - 1, y);
      if (x < this.board[y].length - 1 && this.board[y][x + 1] === marker) floodFill(marker, x + 1, y);
      if (y > 0 && this.board[y - 1][x] === marker) floodFill(marker, x, y - 1);
      if (y < this.board.length - 1 && this.board[y + 1][x] === marker) floodFill(marker, x, y + 1);
    };

    const cell = this.board[y][x];
    if (cell === "B" || cell === "W" || cell === "x") output.owner = cell === "x" ? "NONE" : "NONE";
    else if (cell === "b") output.owner = "BLACK";
    else if (cell === "w") output.owner = "WHITE";

    if (cell !== "B" && cell !== "W") floodFill(cell, x, y);
    output.territory.sort();

    return output;
  }

  getTerritories() {
    return {
      territoryBlack: this.blackTerritory,
      territoryWhite: this.whiteTerritory,
      territoryNone: this.noTerritory,
    };
  }
}
