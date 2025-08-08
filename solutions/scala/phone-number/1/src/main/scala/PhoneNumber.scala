
object PhoneNumber {
  def clean(s: String) = {
    val pattern = "1?([2-9][0-9]{2}[2-9][0-9]{6})".r
    s.filter(_.isLetterOrDigit) match {
      case pattern(number) => Some(number)
      case _ => None
    }
  }
}