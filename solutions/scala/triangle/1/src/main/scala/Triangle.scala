case class Triangle[A](sides: A*)(implicit num: Numeric[A]) {
  require(sides.length == 3)
  import num._

  val Seq(a, b, c) = sides.toList.sorted

  val isValid: Boolean = gt(a + b, c) && a.toDouble > 0

  val equilateral: Boolean = isValid && equiv(a, c)

  val isosceles: Boolean = isValid && (equiv(a, b) || equiv(b, c))

  val scalene: Boolean = isValid && !equiv(a,b) && !equiv(b,c)
}