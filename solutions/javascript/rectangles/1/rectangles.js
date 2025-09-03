export function count(grid) {
  let countRectangle = 0;
  for (let i = 0; i < grid.length; i++) {
    for (let j = 0; j < grid[i].length; j++) {
      if (grid[i].charAt(j) === '+') {
        for (let k = j + 1; k < grid[i].length; k++) {
          if (/^\+[+-]*\+$/.test(grid[i].substring(j, k + 1))) {
             for(let n = i +1; n < grid.length; n++) {
                 if(/^[+|].*[+|]$/.test(grid[n].substring(j,k+1))){
                    if(/^\+[+-]*\+$/.test(grid[n].substring(j, k + 1))){
                      countRectangle++;
                    }
                 }
                 else {
                  break;
                 }
             }    
          }
        }
      }
    }
  }
  return countRectangle;
}