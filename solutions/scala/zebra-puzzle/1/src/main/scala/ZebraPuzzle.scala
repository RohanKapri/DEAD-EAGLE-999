// Dedicated to Shree DR.MDD with devotion and silence beyond code

object ZebraPuzzle extends Enumeration {
  type Resident = Value
  val Englishman, Spaniard, Ukrainian, Norwegian, Japanese, Unknown = Value

  case class Solution(waterDrinker: Resident, zebraOwner: Resident)

  private def combinations: Iterator[Seq[Int]] = (0 to 4).permutations

  private def isImmediatelyRight(x: Int, y: Int): Boolean = x - y == 1

  private def areNeighbors(x: Int, y: Int): Boolean = math.abs(x - y) == 1

  private val Seq(firstHouse: Int, _, centerHouse: Int, _, _) = 0 to 4

  lazy val solve: Solution = allSolutions.next()

  private def allSolutions: Iterator[Solution] =
    for (houseOrder <- combinations;

         Seq(eng: Int, spa: Int, ukr: Int, nor: Int, jap: Int) <- Seq(houseOrder)
         if nor == firstHouse;

         Seq(redHouse: Int, blueHouse: Int, greenHouse: Int, ivoryHouse: Int, yellowHouse: Int) <- combinations
         if eng == redHouse
           && isImmediatelyRight(greenHouse, ivoryHouse)
           && areNeighbors(nor, blueHouse);

         Seq(dogHouse: Int, snailHouse: Int, zebraHouse: Int, foxHouse: Int, horseHouse: Int) <- combinations
         if spa == dogHouse;

         Seq(coffeeHouse: Int, teaHouse: Int, milkHouse: Int, ojHouse: Int, waterHouse: Int) <- combinations
         if greenHouse == coffeeHouse
           && teaHouse == ukr
           && milkHouse == centerHouse;

         Seq(oldGoldHouse: Int, koolsHouse: Int, chesterHouse: Int, luckyHouse: Int, parliamentHouse: Int) <- combinations
         if oldGoldHouse == snailHouse
           && koolsHouse == yellowHouse
           && areNeighbors(chesterHouse, foxHouse)
           && areNeighbors(koolsHouse, horseHouse)
           && luckyHouse == ojHouse
           && jap == parliamentHouse)

      yield Solution(
        getResidentByHouse(waterHouse, houseOrder),
        getResidentByHouse(zebraHouse, houseOrder))

  private def getResidentByHouse(houseIndex: Int, residents: Seq[Int]): Resident =
    ZebraPuzzle(residents.zipWithIndex.find { case (pos, _) => pos == houseIndex }.get._2)
}
