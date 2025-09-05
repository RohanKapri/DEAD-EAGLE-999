Weeks = {First: 1, Second: 8, Teenth: 13, Third: 15, Fourth: 22, Last: -99}
Weekdays = {Sunday: 0, Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6}
meetup = (input) ->
  if input.week is Weeks.Last
    lastDay = new Date input.year, input.month, 0
    startDate = lastDay.getDate() - 6
  else
    startDate = input.week
  date = new Date input.year, input.month - 1, startDate
  while date.getDay() isnt input.dayofweek
    date.setDate date.getDate() + 1
  date
module.exports = {Weeks, Weekdays, meetup}