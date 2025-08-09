proc score*(x,y: float): int =
  let sumOfSquares = x * x + y * y
  if sumOfSquares <= 1:
    return 10
  elif sumOfSquares <= 25:
    return 5
  elif sumOfSquares <= 100:
    return 1
  else:
    return 0