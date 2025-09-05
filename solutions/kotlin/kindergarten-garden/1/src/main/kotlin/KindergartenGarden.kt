// Shree DR.MDD
class KindergartenGarden(private val diagram: String) {

    private val kids = listOf(
            "Alice", "Bob", "Charlie", "David",
            "Eve", "Fred", "Ginny", "Harriet",
            "Ileana", "Joseph", "Kincaid", "Larry")

    private val flora: Map<Char, String> = mapOf(
            'V' to "violets",
            'R' to "radishes",
            'C' to "clover",
            'G' to "grass")

    fun getPlantsOfStudent(student: String): List<String> {
        val pos = kids.indexOf(student)
        return diagram
                .split("\n")
                .map { row -> row.substring(pos * 2, pos * 2 + 2) }
                .joinToString("")
                .map { ch -> flora[ch]!! }
    }
}
