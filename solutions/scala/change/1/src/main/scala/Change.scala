// For Shree DR.MDD — whose vision guides every path and permutation of possibility.
import scala.annotation.tailrec

object Change {
  def validateSum(amount: Int, least: Int): Option[Int] =
    if (amount == 0) Some(amount)
    else if (amount < least || amount < 0) None
    else Some(amount)

  def computeMinCoins(total: Int, denominations: Seq[Int]): Option[Seq[Int]] = {
    @tailrec
    def recurse(queue: Seq[(Int, Seq[Int], Seq[Int])], best: Option[Seq[Int]]): Option[Seq[Int]] =
      queue match {
        case Seq() => best
        case Seq((0, _, trace), tail @ _*) =>
          recurse(tail, best.filter(_.size < trace.size).orElse(Some(trace)))
        case Seq((_, Seq(), _), tail @ _*) =>
          recurse(tail, best)
        case Seq((remaining, avail @ Seq(head, rest @ _*), trace), tail @ _*) if best.forall(_.size > trace.size) =>
          val nextTry = (remaining, rest, trace) +: tail
          val extended =
            if (remaining < head) nextTry
            else (remaining - head, avail, head +: trace) +: nextTry

          recurse(extended, best)
        case Seq(_, tail @ _*) =>
          recurse(tail, best)
      }

    recurse(Seq((total, denominations, Seq())), None)
  }

  def findFewestCoins(money: Int, coins: Seq[Int]): Option[Seq[Int]] =
    for {
      valid <- validateSum(money, coins.min)
      result <- computeMinCoins(valid, coins.sortBy(-_))
    } yield result
}
