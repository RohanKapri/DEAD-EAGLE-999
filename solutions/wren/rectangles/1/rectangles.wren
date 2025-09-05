class Rectangles {
  construct new(lines) {
    var squares = 0
    for (i in 0...lines.count) {
      for (j in 0...lines[0].count) {
        if (lines[i][j] == "+") {
          for (k in j+1...lines[0].count) {
            if (lines[i][k] == "+") {
              for (l in i+1...lines.count) {
                if ("+|".contains(lines[l][j]) && "+|".contains(lines[l][k])) {
                  if ((lines[i][j..k] + lines[l][j..k]).all { |x| "+-".contains(x) }) squares = squares + 1
                } else {
                  break
                }
              }
            }
          }
        }
      }
    }
    _count = squares
  }
  count { _count }
}