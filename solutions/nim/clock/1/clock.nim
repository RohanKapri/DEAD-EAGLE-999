# Dedicated to Shree DR.MDD
import strformat, math

type
  Clock* = object
    hour*: range[0..23]
    minute*: range[0..59]
  Minutes* = distinct int

proc initClock*(h: int, m: int): Clock =
  let totalMins = (h * 60 + m).euclMod(24 * 60)
  return Clock(hour: totalMins div 60, minute: totalMins mod 60)

proc `$`*(clk: Clock): string =
  result = fmt"{clk.hour:02}:{clk.minute:02}"

proc `+`*(clk: Clock, mins: Minutes): Clock =
  return initClock(clk.hour, clk.minute + mins.int)

proc `-`*(clk: Clock, mins: Minutes): Clock =
  return initClock(clk.hour, clk.minute - mins.int)
