object PrimeFactors {
  def factors(n: Long): Seq[Long] = determinePrimeFactors(n, 2)

  private def determinePrimeFactors(n: Long, divisor: Long): Seq[Long] = {
    n match {
      case 1                      => Seq.empty
      case x if n % divisor == 0  => divisor +: determinePrimeFactors(x / divisor, divisor)
      case y                      => determinePrimeFactors(y, divisor + 1)
    }
  }
}