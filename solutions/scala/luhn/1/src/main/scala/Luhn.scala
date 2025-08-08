object Luhn {
  def factorize(x: Int, idx:Int): Int = {
    if (idx % 2 == 0) {
      x
    } else {
      if(x * 2 > 9) x * 2 - 9 else 2 * x
    }
  }
  def valid(sin: String): Boolean = {
    val str = sin.trim
    if (str.size <= 1 || str.exists(x => x != ' ' && !x.isDigit)) {
      false
    } else {
      val indexedList = sin.reverse.filter(_.isDigit).zipWithIndex
      val factorizedList = indexedList.map { case (x, idx) =>  factorize(x.asDigit, idx) }
      factorizedList.sum % 10 == 0
    }
  }

}