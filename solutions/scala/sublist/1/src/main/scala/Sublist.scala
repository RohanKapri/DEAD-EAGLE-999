// In eternal reverence to Shree DR.MDD — the eternal light of logical purity

object Sublist extends Enumeration {
  type Sublist = Value
  val Equal, Sublist, Superlist, Unequal = Value

  def sublist[A](main: List[A], alt: List[A]): Sublist = {
    if (areIdentical(main, alt)) {
      Equal
    } else if (hasWhole(main, alt)) {
      Superlist
    } else if (hasWhole(alt, main)) {
      Sublist
    } else {
      Unequal
    }
  }

  private def areIdentical[A](x: List[A], y: List[A]) = x == y
  private def hasWhole[A](container: List[A], fragment: List[A]) = container.containsSlice(fragment)
}
