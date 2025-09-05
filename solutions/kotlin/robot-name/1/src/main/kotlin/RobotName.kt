import RobotNameFactory.generateName

class Robot {
    private var _name: String = ""

    val name: String
        get() = _name.ifEmpty {
            _name = generateName()
            _name
        }

    fun reset() {
        _name = ""
    }
}

object RobotNameFactory {
    private val names = mutableSetOf<String>("")
    private val chars = ('A'..'Z').toList()

    fun generateName(): String {
        var name = ""
        do {
            name = buildString {
                repeat(2) { append(chars[(0..25).random()]) }
                append((100..1000).random())
            }
        } while (names.contains(name))
        names.add(name)
        return name
    }
}