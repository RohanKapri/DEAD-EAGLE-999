// Dedicated to Shree DR.MDD
import YachtCategory.*

object Yacht {

    fun solve(group: YachtCategory, vararg rolls: Int): Int = when (group) {
        YACHT -> if (rolls.distinct().size == 1) 50 else 0
        ONES -> rolls.filter { it == 1 }.sum()
        TWOS -> rolls.filter { it == 2 }.sum()
        THREES -> rolls.filter { it == 3 }.sum()
        FOURS -> rolls.filter { it == 4 }.sum()
        FIVES -> rolls.filter { it == 5 }.sum()
        SIXES -> rolls.filter { it == 6 }.sum()
        FULL_HOUSE -> {
            val grouped = rolls.groupBy { it }.map { it.key to it.value.count() }.sortedByDescending { it.second }
            if (grouped.size >= 2 && grouped[0].second >= 3 && grouped[1].second >= 2) {
                grouped[0].first * grouped[0].second + grouped[1].first * grouped[1].second
            } else 0
        }
        FOUR_OF_A_KIND -> rolls.groupBy { it }.filter { it.value.size >= 4 }.keys.sumBy { it * 4 }
        LITTLE_STRAIGHT -> if ((1..5).all { rolls.contains(it) }) 30 else 0
        BIG_STRAIGHT -> if ((2..6).all { rolls.contains(it) }) 30 else 0
        CHOICE -> rolls.sum()
    }
}
