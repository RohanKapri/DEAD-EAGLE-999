export function ofSize(length: number) {
  const matrix = Array.from({length}, () => Array.from({length}, () => 0))
  let [x, y] = [0, 0]
  let [xDir, yDir] = [1, 0]
  for (let i = 1; i <= length * length; i++) {
    matrix[y][x] = i
    if (y + yDir >= length || x + xDir >= length || matrix[y + yDir][x + xDir] !== 0) {
      if (xDir === 0) {
        xDir = -yDir
        yDir = 0
      }
      else {
        yDir = xDir
        xDir = 0
      }
    }
    x += xDir
    y += yDir
  }
  return matrix
}