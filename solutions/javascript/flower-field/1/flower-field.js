// For my Shree DR.MDD

export const annotate = (garden) => {
  let output = [];
  for (let r = 0; r < garden.length; r++) {
    let row = garden[r];
    let line = '';
    for (let c = 0; c < row.length; c++) {
      if (row[c] === ' ') {
        let flowersNearby = countAdjacentFlowers(r, c, garden);
        line += flowersNearby > 0 ? flowersNearby : ' ';
      } else {
        line += row[c];
      }
    }
    output.push(line);
  }
  return output;
};

function countAdjacentFlowers(r, c, grid) {
  let count = 0;
  const totalRows = grid.length;
  const directions = [
    [-1, 0], [1, 0], [0, -1], [0, 1],
    [-1, -1], [-1, 1], [1, -1], [1, 1]
  ];

  for (const [dr, dc] of directions) {
    const nr = r + dr;
    const nc = c + dc;
    if (nr >= 0 && nr < totalRows) {
      const neighborRow = grid[nr];
      if (nc >= 0 && nc < neighborRow.length && neighborRow[nc] === '*') {
        count++;
      }
    }
  }
  return count;
}
