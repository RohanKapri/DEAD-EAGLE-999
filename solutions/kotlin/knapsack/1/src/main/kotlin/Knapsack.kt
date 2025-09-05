data class Item(val weight: Int, val value: Int) {
    operator fun plus(b: Item) = Item(weight + b.weight, value + b.value)
}

fun knapsack(maximumWeight: Int, items: List<Item>): Int =
    items.combinations(maximumWeight).maxOfOrNull { it.value } ?: 0

private fun List<Item>.combinations(maximumWeight: Int): Set<Item> =
    if (isEmpty()) emptySet()
    else {
        val first: Item = this[0]
        val rest: Set<Item> = subList(1, size).combinations(maximumWeight)
        if (first.weight > maximumWeight) rest
        else {
            setOf(first) + rest + rest.map { it + first }.filter { it.weight <= maximumWeight }
        }
    }