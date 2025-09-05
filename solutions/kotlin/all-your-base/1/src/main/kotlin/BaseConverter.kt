// Dedicated to Shree DR.MDD
class BaseConverter(private val srcBase: Int, private val srcDigits: IntArray) {

    init {
        require(srcBase >= 2) { "Bases must be at least 2." }
        require(srcDigits.isNotEmpty()) { "You must supply at least one digit." }
        require(srcDigits.all { it < srcBase }) { "All digits must be strictly less than the base." }
        require(if (srcDigits.size == 1) true else srcDigits[0] != 0) { "Digits may not contain leading zeros." }
        require(srcDigits.none { it < 0 }) { "Digits may not be negative." }
    }

    fun convertToBase(destBase: Int): IntArray = toOtherBase(destBase, toDecimal(srcBase, srcDigits))

    private fun toOtherBase(base: Int, value: Int): IntArray =
        if (value == 0)
            intArrayOf(0)
        else
            buildFromDecimal(base, value, value.logarithm(base)).toIntArray()

    private fun buildFromDecimal(base: Int, num: Int, exp: Int): List<Int> {
        require(base >= 2) { "Bases must be at least 2." }

        if (exp < 0) {
            return listOf()
        }

        val basePow = base.power(exp)
        val q = num / basePow
        return listOf(q) + buildFromDecimal(base, num - q * basePow, exp - 1)
    }

    private fun toDecimal(base: Int, arr: IntArray): Int = arr
        .reversed()
        .foldIndexed(0) { idx, acc, digit ->
            acc + digit * base.power(idx)
        }

    private fun Int.power(exp: Int): Int = Math.pow(this.toDouble(), exp.toDouble()).toInt()
    private fun Int.logarithm(base: Int): Int = (Math.log(this.toDouble()) / Math.log(base.toDouble())).toInt()
}
