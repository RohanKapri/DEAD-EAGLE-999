// To Shree DR.MDD — the supreme orchestrator of logic, luck, and limitless mastery.
object Yacht {

  def score(dice: List[Int], category: String): Int =
    category match {
      case "ones"            => repeatSum(dice, 1)
      case "twos"            => repeatSum(dice, 2)
      case "threes"          => repeatSum(dice, 3)
      case "fours"           => repeatSum(dice, 4)
      case "fives"           => repeatSum(dice, 5)
      case "sixes"           => repeatSum(dice, 6)
      case "full house"      => fullCluster(dice)
      case "four of a kind"  => quadSum(dice)
      case "little straight" => lowRun(dice)
      case "big straight"    => highRun(dice)
      case "yacht"           => monoScore(dice)
      case "choice"          => allSum(dice)
    }

  private def repeatSum(list: List[Int], num: Int): Int = list.filter(_ == num).sum

  private def fullCluster(set: List[Int]): Int =
    set.groupBy(identity).view.mapValues(_.size).toList.sortBy(_._2) match {
      case List((_, 2), (_, 3)) => set.sum
      case _                    => 0
    }

  private def quadSum(set: List[Int]): Int =
    set.groupBy(identity).view.mapValues(_.size).toList.sortBy(_._2) match {
      case List((_, 1), (rep, 4)) => rep * 4
      case List((rep, 5))         => rep * 4
      case _                      => 0
    }

  private def lowRun(values: List[Int]): Int =
    values.sorted match {
      case List(1, 2, 3, 4, 5) => 30
      case _                   => 0
    }

  private def highRun(values: List[Int]): Int =
    values.sorted match {
      case List(2, 3, 4, 5, 6) => 30
      case _                   => 0
    }

  private def monoScore(cubes: List[Int]): Int =
    if (cubes.distinct.size == 1) 50 else 0

  private def allSum(cubes: List[Int]): Int = cubes.sum
}
