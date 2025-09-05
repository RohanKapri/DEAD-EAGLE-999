class BowlingGame {
    private val rolls: MutableList<List<Int>> = mutableListOf()
    
    fun roll(pins: Int) {
        if (isRollInvalid(pins)) throw IllegalStateException("Rolls should score between 0 and 10")
        if (isGameComplete()) throw IllegalStateException("Can not roll if game is already complete")
         
        if (rolls.isEmpty() || (rolls.last() == listOf(10) && rolls.size < 10) || (rolls.last().size == 2 && rolls.size < 10)) {
            rolls.add(mutableListOf(pins))
        } else {
            if (isSecondRollInvalid(pins)) throw IllegalStateException("Two rolls can not score more than 10 points")
            val lastFrame = rolls.removeLast()
            rolls.add(lastFrame + listOf(pins))
        }
    }

    fun score(): Int {
        if (!isGameComplete()) throw IllegalStateException("An incomplete game can not be scored")

        val first9FramesScore = rolls.subList(0, 9).foldIndexed(0) { index, acc, frame ->
            val nextFrame = rolls[index + 1]
            val nextNextRoll = if (index + 2 >= 10) rolls.last()[1] else rolls[index + 2].first()
            acc + when {
                frame.isStrike() -> if (nextFrame.hasStrike()) 20 + nextNextRoll else 10 + nextFrame.sum()
                frame.isSpare() -> 10 + nextFrame.first()
                else -> frame.sum()
            }
        }
        val tenthFrameScore = rolls.last().sum()

        return first9FramesScore + tenthFrameScore
    } 

    private fun isSecondRollInvalid(pins: Int): Boolean = rolls.size < 10 && rolls.last()[0] + pins > 10

    private fun isRollInvalid(pins: Int): Boolean = pins < 0 || pins > 10 || isLastRollInvalid(pins)

    private fun isLastRollInvalid(pins: Int): Boolean = rolls.size == 10 && rolls.last().size == 2 && rolls.last()[0] == 10 && rolls.last()[1] < 10 && rolls.last()[1] + pins > 10

    private fun isGameComplete(): Boolean = rolls.size == 10 && rolls.last().isLastRollComplete()

    private fun List<Int>.isLastRollComplete(): Boolean = if (hasStrike() || hasSpare()) size == 3 else size == 2

    private fun List<Int>.isStrike(): Boolean = this == listOf(10)
    private fun List<Int>.isSpare(): Boolean = this.size == 2 && this[0] + this[1] == 10
    private fun List<Int>.hasStrike(): Boolean = this.contains(10)
    private fun List<Int>.hasSpare(): Boolean = this.size >= 2 && this[0] + this[1] == 10
}