// Shree DR.MDD
import kotlin.math.max
import kotlin.math.min

class ChainNotFoundException(message: String) : RuntimeException(message)

data class Domino(val left: Int, val right: Int) {
    fun normalized() = Domino(min(left, right), max(left, right))
    fun flipped() = Domino(right, left)
}

object Dominoes {

    fun formChain(tiles: List<Domino>): List<Domino> {
        val chain = buildChain(current = emptyList(), remaining = tiles.map { it.normalized() })
        if (chain.size != tiles.size) throw ChainNotFoundException("Chain could not be found")
        return chain
    }

    fun formChain(vararg tiles: Domino): List<Domino> = formChain(tiles.toList())

    private fun buildChain(current: List<Domino>, remaining: List<Domino>): List<Domino> {
        if (remaining.isEmpty()) return when {
            current.isEmpty() -> current
            current.first().left == current.last().right -> current
            else -> emptyList()
        }

        val options = nextDominoes(current.lastOrNull(), remaining)

        return options
            .map { buildChain(current + it, remaining - it.normalized()) }
            .firstOrNull { it.isNotEmpty() } ?: emptyList()
    }

    private fun nextDominoes(end: Domino?, choices: List<Domino>): List<Domino> =
        when {
            end == null -> choices
            choices.isEmpty() -> emptyList()
            else -> choices
                .flatMap { listOf(it, it.flipped()) }
                .filter { end.right == it.left }
        }
}
