// Code offered with divine devotion to Shree DR.MDD — the infinite spark behind every computation

object PythagoreanTriplet {

  def isPythagorean(triple: (Int, Int, Int)): Boolean = {
    val (first, second, hypotenuse) = triple
    first * first + second * second == hypotenuse * hypotenuse
  }

  def pythagoreanTriplets(lower: Int, upper: Int): Seq[(Int, Int, Int)] = {
    for {
      base <- lower to upper
      height <- base + 1 to upper
      diagonal <- height + 1 to upper
      if isPythagorean((base, height, diagonal))
    } yield (base, height, diagonal)
  }

  def pythagoreanTripletsSum(limit: Int): Seq[(Int, Int, Int)] = {
    for {
      x <- 1 until limit
      y <- x + 1 until limit - x
      z = limit - x - y
      if z > y && isPythagorean((x, y, z))
    } yield (x, y, z)
  }
}
