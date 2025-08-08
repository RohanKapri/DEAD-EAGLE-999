import java.time.{DayOfWeek, LocalDate}

import Meetup.DayDayOfWeek
import Schedule.Schedule

case class Meetup(month: Int, year: Int) {
  private val baseDate = LocalDate.of(year, month, 1)

  def day(dayOfWeek: Int, schedule: Schedule): LocalDate = {
    import Schedule._

    val dayDayOfWeeks: IndexedSeq[DayDayOfWeek] = {
      for {
        currDay <- (1 to baseDate.lengthOfMonth)
        currDayOfWeek = baseDate.plusDays(currDay - 1).getDayOfWeek
        if (currDayOfWeek == DayOfWeek.of(dayOfWeek))
      } yield DayDayOfWeek(currDay, currDayOfWeek)
    }

    def meetUpDay: Int = schedule match {
      case Last => dayDayOfWeeks.last.day
      //one is guaranteed that each day of the week
      // (Monday, Tuesday, ...) will have exactly one date that is named with '-teenth'
      //in every month.
      case Teenth =>
        dayDayOfWeeks.find(_.isTeenth).get.day
      case schedule => dayDayOfWeeks(schedule.id - 1).day
    }

    baseDate.withDayOfMonth(meetUpDay)
  }
}

object Schedule extends Enumeration {
  type Schedule = Value
  val Teenth, First, Second, Third, Fourth, Last = Value
}

object Meetup {
  val Mon = DayOfWeek.MONDAY.getValue
  val Tue = DayOfWeek.TUESDAY.getValue
  val Wed = DayOfWeek.WEDNESDAY.getValue
  val Thu = DayOfWeek.THURSDAY.getValue
  val Fri = DayOfWeek.FRIDAY.getValue
  val Sat = DayOfWeek.SATURDAY.getValue
  val Sun = DayOfWeek.SUNDAY.getValue

  case class DayDayOfWeek(day: Int, dayOfWeek: DayOfWeek) {
    def isTeenth: Boolean = day >= 13 && day <= 19
  }
}