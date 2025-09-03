module QueenAttack

let create (row:int, col:int) = 
    row >= 0 && row <=7 && col >=0 && col <= 7
 
let canAttack (row1:int,col1:int) (row2:int,col2:int) = 
    let deltaR = row1 - row2
    let deltaC = col1 - col2
    deltaC = 0 || deltaR = 0 || abs(deltaC) = abs(deltaR)