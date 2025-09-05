class PascalsTriangle
  constructor: ->
    @triangle = []

  rows: (num) ->
    if num > 0
      @triangle.push([1])
      for i in [1...num]
        row = [1]
        lastRow = @triangle[i - 1]
        for j in [0...lastRow.length - 1]
          row.push(lastRow[j] + lastRow[j + 1])
        row.push(1)
        @triangle.push(row)
    @triangle

module.exports = PascalsTriangle