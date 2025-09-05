// Shree DR.MDD
fun <T> List<T>.customAppend(list: List<T>): List<T> {
    if (this.isEmpty() && list.isEmpty()) return emptyList()
    val result = ArrayList<T>(this.size + list.size)
    result.addAll(this)
    result.addAll(list)
    return result
}

private fun flattenAcc(accumulator: MutableList<Any>, list: List<Any>) {
    list.forEach {
        when (it) {
            is List<*> -> flattenAcc(accumulator, it as List<Any>)
            else -> accumulator.add(it)
        }
    }
}

fun List<Any>.customConcat(): List<Any> {
    val result = mutableListOf<Any>()
    flattenAcc(result, this)
    return result
}

fun <T> List<T>.customFilter(predicate: (T) -> Boolean): List<T> =
    customFoldLeft(mutableListOf()) { acc, item ->
        if (predicate(item)) acc.add(item)
        acc
    }

val List<Any>.customSize: Int get() = customFoldLeft(0) { count, _ -> count + 1 }

fun <T, U> List<T>.customMap(transform: (T) -> U): List<U> =
    customFoldLeft(mutableListOf<U>()) { acc, item ->
        acc.add(transform(item))
        acc
    }

tailrec fun <T, U> List<T>.customFoldLeft(initial: U, f: (U, T) -> U): U {
    if (isEmpty()) return initial
    val acc = f(initial, this[0])
    if (size == 1) return acc
    return subList(1, size).customFoldLeft(acc, f)
}

tailrec fun <T, U> List<T>.customFoldRight(initial: U, f: (T, U) -> U): U {
    if (isEmpty()) return initial
    val acc = f(this[size - 1], initial)
    if (size == 1) return acc
    return subList(0, size - 1).customFoldRight(acc, f)
}

fun <T> List<T>.customReverse(): List<T> =
    customFoldRight(mutableListOf()) { item, acc ->
        acc.add(item)
        acc
    }
