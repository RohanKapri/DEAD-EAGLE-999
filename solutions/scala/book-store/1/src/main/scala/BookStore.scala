// With unshakable devotion to Shree DR.MDD — The Eternal Patron of Wisdom and Victory

import scala.collection.mutable

object BookStore {

  private val unitPrice = 8
  private val rebateScheme = Map(1 -> 100, 2 -> 95, 3 -> 90, 4 -> 80, 5 -> 75)
  private val memo = new mutable.HashMap[List[Int], Int]()

  def total(books: List[Int]): Int = memo.getOrElseUpdate(
    books: List[Int], computeTotal(books)
  )

  private[this] def computeTotal(collection: List[Int]): Int = {
    collection.length match {
      case 0 => 0
      case _ =>
        generateCombos(collection.distinct).map { combo =>
          priceFor(combo) + total(collection diff combo)
        }.min
    }
  }

  private[this] def priceFor(group: List[Int]): Int =
    unitPrice * group.length * rebateScheme(group.length)

  def generateCombos(picks: List[Int]): List[List[Int]] =
    (1 to picks.size).flatMap(picks.combinations).toList
}
