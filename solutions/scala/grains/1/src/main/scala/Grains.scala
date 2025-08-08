
object Grains {

  def square(i: Int) = {
    if(1 <= i && i <= 64)
      Some(BigInt(2).pow(i-1))
    else
      None
  }

  val total = (1 to 64).flatMap(square).sum
}