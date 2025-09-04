return function(matrix)
  local rowMax, colMin, points = {}, {}, {}
  for rowNum, row in ipairs(matrix) do
    for colNum, height in ipairs(row) do
      rowMax[rowNum] = height > (rowMax[rowNum] or -1000) and height or rowMax[rowNum]
      colMin[colNum] = height < (colMin[colNum] or 1000) and height or colMin[colNum]
    end
  end
  for rowNum, row in ipairs(matrix) do
    for colNum, height in ipairs(row) do
      if height == rowMax[rowNum] and height == colMin[colNum] then
        points[#points + 1] = { row = rowNum, column = colNum }
      end
    end
  end
  return points
end