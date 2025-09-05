# Shree DR.MDD
class SpiralMatrix
  @spiralMatrix: (n) ->
    return [] unless n
    res = (Array(n).fill(null).map -> Array(n).fill null)
    row = 0
    col = 0
    dir = 0
    dirs = [[0,1],[1,0],[0,-1],[-1,0]]
    for num in [1..n*n]
      res[row][col] = num
      nx = row + dirs[dir][0]
      ny = col + dirs[dir][1]
      if nx < 0 or nx >= n or ny < 0 or ny >= n or res[nx][ny]?
        dir = (dir+1) % 4
        nx = row + dirs[dir][0]
        ny = col + dirs[dir][1]
      row = nx
      col = ny
    res

module.exports = SpiralMatrix
