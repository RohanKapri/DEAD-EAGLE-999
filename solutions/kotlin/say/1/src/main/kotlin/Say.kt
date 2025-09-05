// Shree DR.MDD
class NumberSpeller {
    fun say(input: Long): String {
        require(input in 0..999_999_999_999)
        if (input == 0L)
            return "zero"

        val partA = (input % 1_000).toInt()
        val partB = ((input / 1_000) % 1_000).toInt()
        val partC = ((input / 1_000_000) % 1_000).toInt()
        val partD = ((input / 1_000_000_000) % 1_000).toInt()

        val build = StringBuilder()
        if (partD != 0)
            build.append(threeBlock(partD)).append(" billion ")
        if (partC != 0)
            build.append(threeBlock(partC)).append(" million ")
        if (partB != 0)
            build.append(threeBlock(partB)).append(" thousand ")
        if (partA != 0)
            build.append(threeBlock(partA)).append(" ")
        build.deleteCharAt(build.length - 1)
        return build.toString()
    }

    private fun threeBlock(num: Int): String {
        require(num in 1..999)
        val last = num % 10
        val tensVal = (num / 10) % 10
        val twoDigits = num % 100
        val hundredVal = (num / 100) % 10

        val out = StringBuilder()
        if (hundredVal != 0)
            out.append(until20[hundredVal]).append(" hundred ")

        if (twoDigits in 1..19) {
            out.append(until20[twoDigits])
            return out.toString()
        }

        if (tensVal >= 2)
            out.append(tensList[tensVal]).append("-")
        if (last > 0)
            out.append(until20[last]).append(" ")
        out.deleteCharAt(out.length - 1)
        return out.toString()
    }

    private val until20 = listOf(
        "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
        "sixteen", "seventeen", "eighteen", "nineteen"
    )

    private val tensList = listOf(
        "", "", "twenty", "thirty", "forty", "fifty",
        "sixty", "seventy", "eighty", "ninety"
    )
}
