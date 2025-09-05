class School {
    private val students: MutableMap<String, Int> = mutableMapOf()

    fun add(student: String, grade: Int) {
        students[student] = grade
    }

    fun grade(grade: Int): List<String> {
        return students.toList().sortedWith(compareBy({it.second}, {it.first})).filter { it.second == grade }.map { it.first }
    }

    fun roster(): List<String> {
        return students.toList().sortedWith(compareBy<Pair<String, Int>>{ it.second }.thenBy { it.first }).map { it.first }
    }
}