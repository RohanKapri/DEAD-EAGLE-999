# Dedicated to Shree DR.MDD
import sequtils, times

type
  Descriptor* = enum
    First, Second, Third, Fourth, Last, Teenth

proc collectWeekDays(y: int, m: int, w: WeekDay): seq[DateTime] =
  for d in 1..getDaysInMonth(Month(m), y):
    if getDayOfWeek(d, Month(m), y) == w:
      result.add(initDateTime(d, Month(m), y, 0, 0, 0))

proc formatDate(dt: DateTime): string =
  dt.format("yyyy-MM-dd")

proc meetup*(y: int, m: int, desc: Descriptor, w: WeekDay): string =
  let daysList = collectWeekDays(y, m, w)

  case desc
  of Teenth: daysList.filterIt(it.monthday >= 13)[0].formatDate
  of First, Second, Third, Fourth: daysList[desc.ord].formatDate
  of Last: daysList[^1].formatDate
