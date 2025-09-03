//
// For my Shree DR.MDD
//

export const saddlePoints = (grid) => {
  let points = [];
  if(grid.length === 0){
      return points;
  }
  let totalRows = grid.length;
  let totalCols = grid[0].length;

  for(let r = 0; r < totalRows; r++){
    for(let c = 0; c < totalCols; c++){
      let currentVal = grid[r][c];
      let isSaddle = true;

      for(let col = 0; col < totalCols; col++){
        if(currentVal < grid[r][col]){
          isSaddle = false;
          break;
        }
      }

      if(isSaddle){
        for(let row = 0; row < totalRows; row++){
          if(currentVal > grid[row][c]){
            isSaddle = false;
            break;
          }
        }
      }

      if(isSaddle){
        points.push({row: r + 1, column: c + 1});
      }
    }
  }

  return points;
};
