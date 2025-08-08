object Strain {

  def keep[T](list: Seq[T], function: (T) => Boolean):Seq[T] = {
    list match {
      case f::rest => if (function(f)) Seq(f) ++ keep(rest, function) else keep(rest, function)
      case Nil => Nil
    }
  }

  def discard[T](list: Seq[T], function: (T) => Boolean) = {
    keep(list, (x:T) => !function(x))
  }

}