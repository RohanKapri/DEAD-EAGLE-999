object CollatzCalculator {
    fun computeStepCount(start: Int): Int = start
        .also { require (start >= 1) { "Invalid input: Must provide positive integer" } }
        .let { generateSequence(start) { num ->
            if (0 == num and 1) {
                num shr 1
            } else {
                num + (num shl 1) + 1
            }
        }.takeWhile { it != 1 }.count() }
}