enum class Relationship {

    EQUAL, SUBLIST, SUPERLIST, UNEQUAL

}

private fun <T> List<T>.containsList(other: List<T>): Boolean {
    if (other.isEmpty()) return true
    if (other.size > this.size) return false

    return this.windowed(other.size) {it == other}.any { it }
}

fun <T> List<T>.relationshipTo(other: List<T>): Relationship {
    return when {
        this == other -> Relationship.EQUAL
        this.containsList(other) -> Relationship.SUPERLIST
        other.containsList(this) -> Relationship.SUBLIST
        else -> Relationship.UNEQUAL
    }
}