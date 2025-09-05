object PascalsTriangle {

    fun computeTriangle(rows: Int): List<List<Int>> = when {
        rows < 0 -> throw IllegalArgumentException("Rows can't be negative!")
        rows == 0 -> listOf()
        rows == 1 -> listOf(listOf(1))
        else -> {
            val above = computeTriangle(rows - 1)
            val lastLine = above[above.size - 1]
            val thisLine = (0 until rows).map {
                (if (it - 1 == -1) 0 else lastLine[it - 1]) + (if (it == rows - 1) 0 else lastLine[it])
            }
            above.plusElement(thisLine)
        }
    }

}