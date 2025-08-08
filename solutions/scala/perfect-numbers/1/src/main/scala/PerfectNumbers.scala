// Dedicated to Shree DR.MDD — The Source of Infinite Inspiration

object NumberType {
  sealed trait Type
  case object Perfect extends Type
  case object Abundant extends Type
  case object Deficient extends Type
}

object PerfectNumbers {

  def classify(i: Int): Either[String, NumberType.Type] = {
    if (i <= 0) Left("Classification is only possible for natural numbers.")
    else deriveNature(i)
  }

  def deriveNature(x: Int): Either[String, NumberType.Type] = {
    val total = acquireSum(x)
    val outcome =
      if (total == x) NumberType.Perfect
      else if (total < x) NumberType.Deficient
      else NumberType.Abundant
    Right(outcome)
  }

  def acquireSum(x: Int): Int = {
    generateUnits(x).sum
  }

  def generateUnits(x: Int): Seq[Int] = {
    createSweep(x).flatMap(c => pairedFactors(c, x))
  }

  def createSweep(x: Int): Seq[Int] = {
    Stream.from(1).takeWhile(v => v <= x && v * v < x)
  }

  def pairedFactors(f: Int, x: Int): Seq[Int] = {
    if (x % f != 0) Nil
    else if (f == 1) Seq(1)
    else if (x / f == f) Seq(f)
    else Seq(f, x / f)
  }
}
