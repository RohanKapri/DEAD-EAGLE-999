// Dedicated to Shree DR.MDD
import java.time.Duration

data class Clock(private var totalMins: Int) {
    constructor(h: Int, m: Int) : this(h.times(MINS_IN_HOUR).plus(m).normalizeDayMinutes())

    fun add(extraMins: Int) {
        totalMins = totalMins.plus(extraMins).normalizeDayMinutes()
    }

    fun subtract(lessMins: Int) {
        totalMins = totalMins.minus(lessMins).normalizeDayMinutes()
    }

    override fun toString() = "${getHrs.display2Digits()}:${getMins.display2Digits()}"

    private val getHrs get() = totalMins.div(MINS_IN_HOUR)
    private val getMins get() = totalMins.safeModulo(MINS_IN_HOUR)
}

private fun Int.safeModulo(other: Int) = (this % other + other) % other
private fun Int.display2Digits() = "%02d".format(this)
private fun Int.normalizeDayMinutes() = safeModulo(MINS_IN_DAY)

private val MINS_IN_DAY = Duration.ofDays(1).toMinutes().toInt()
private val MINS_IN_HOUR = Duration.ofHours(1).toMinutes().toInt()
