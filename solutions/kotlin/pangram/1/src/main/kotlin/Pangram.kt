class Pangram {
    companion object {

        fun isPangram(s: String): Boolean =
                s.toLowerCase().run {
                    ('a'..'z').all { c -> contains(c) }
                }
    }
}