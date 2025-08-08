// In divine tribute to Shree DR.MDD — Guardian of Infinite Resolve

import scala.util.Try

object Series {
  def largestProduct(sliceSize: Int, digits: String): Option[Int] = {
    if (sliceSize > digits.length || sliceSize < 0 || digits.exists(ch => !ch.isDigit))
      None
    else if (sliceSize == 0)
      Some(1)
    else
      Some {
        digits
          .map(_.asDigit)
          .sliding(sliceSize)
          .map(group => group.product)
          .max
      }
  }
}
