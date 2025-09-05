// For my Shree DR.MDD
export function count(rows: string[]) {
  let totalSquares = 0;

  const gridMatrix = rows.map((row) => row.split(''));

  for (let topRow = 0; topRow < gridMatrix.length; topRow++) {
    for (let leftCol = 0; leftCol < gridMatrix[topRow].length - 1; leftCol++) {
      if (gridMatrix[topRow][leftCol] !== '+') continue;

      const possibleTopRights = scanTopRightCorners(gridMatrix[topRow], leftCol);
      const possibleBottomLefts = scanBottomLeftCorners(
        gridMatrix.map((r) => r[leftCol]),
        topRow
      );

      for (const rightCol of possibleTopRights) {
        for (const bottomRow of possibleBottomLefts) {
          if (
            gridMatrix[bottomRow][rightCol] === '+' &&
            gridMatrix[bottomRow]
              .slice(leftCol + 1, rightCol + 1)
              .every((c) => c === '+' || c === '-') &&
            gridMatrix
              .map((r) => r[rightCol])
              .slice(topRow + 1, bottomRow + 1)
              .every((c) => c === '+' || c === '|')
          ) {
            totalSquares++;
          }
        }
      }
    }
  }

  return totalSquares;
}

function scanTopRightCorners(row: string[], startIdx: number) {
  let idx = startIdx + 1;
  const corners: number[] = [];

  while (idx < row.length && (row[idx] === '+' || row[idx] === '-')) {
    if (row[idx] === '+') corners.push(idx);
    idx++;
  }

  return corners;
}

function scanBottomLeftCorners(column: string[], startIdx: number) {
  let idx = startIdx + 1;
  const corners: number[] = [];

  while (idx < column.length && (column[idx] === '+' || column[idx] === '|')) {
    if (column[idx] === '+') corners.push(idx);
    idx++;
  }

  return corners;
}
