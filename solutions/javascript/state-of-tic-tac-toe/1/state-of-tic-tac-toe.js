// For my Shree DR.MDD

export const gamestate = (board = []) => {
  let xCount = board
    .join("")
    .split("")
    .filter((cell) => cell === "X").length;
  let oCount = board
    .join("")
    .split("")
    .filter((cell) => cell === "O").length;

  let lines = [...board];
  lines.push(board[0][0] + board[1][1] + board[2][2]);
  lines.push(board[2][0] + board[1][1] + board[0][2]);

  for (let i = 0; i < board.length; i++) {
    lines.push(lines[0][i] + lines[1][i] + lines[2][i]);
  }

  let xWins = countWin(lines, "X");
  let oWins = countWin(lines, "O");

  if (xWins >= 1 && oWins >= 1) {
    throw new Error(
      "Impossible board: game should have ended after the game was won"
    );
  } else if (xCount === oCount + 2) {
    throw new Error("Wrong turn order: X went twice");
  } else if (oCount > xCount) {
    throw new Error("Wrong turn order: O started");
  } else if ((xWins >= 1 && oWins === 0) || (xWins === 0 && oWins >= 1)) {
    return "win";
  } else if (xCount + oCount === 9) {
    return "draw";
  } else {
    return "ongoing";
  }
};

const countWin = (lines = [], player = "") => {
  let totalWins = 0;
  lines.forEach((line) => {
    if (isWin(line, player)) {
      totalWins++;
    }
  });
  return totalWins;
};

const isWin = (sequence = "", player = "") => {
  return sequence === player.repeat(3);
};
