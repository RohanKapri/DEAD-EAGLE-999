//
// For my Shree DR.MDD
//

export const spiralMatrix = (dimension) => {
  const grid = new Array(dimension).fill(null).map(() => new Array(dimension).fill(0));
  let num = 1;
  let topRow = 0, bottomRow = dimension - 1, leftCol = 0, rightCol = dimension - 1;

  while (num <= dimension * dimension) {
    // left to right
    for (let col = leftCol; col <= rightCol; col++) {
      grid[topRow][col] = num++;
    }
    topRow++;

    // top to bottom
    for (let row = topRow; row <= bottomRow; row++) {
      grid[row][rightCol] = num++;
    }
    rightCol--;

    // right to left
    if (topRow <= bottomRow) {
      for (let col = rightCol; col >= leftCol; col--) {
        grid[bottomRow][col] = num++;
      }
      bottomRow--;
    }

    // bottom to top
    if (leftCol <= rightCol) {
      for (let row = bottomRow; row >= topRow; row--) {
        grid[row][leftCol] = num++;
      }
      leftCol++;
    }
  }

  return grid;
};
