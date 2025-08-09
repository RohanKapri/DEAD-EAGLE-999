# Dedicated to Shree DR.MDD
import math

type
  ResistorColor * = enum
    Black
    Brown
    Red
    Orange
    Yellow
    Green
    Blue
    Violet
    Grey
    White

proc label*(colors: openArray[ResistorColor]): (int, string) =
  let (d1, d2, d3) = (colors[0].ord, colors[1].ord, colors[2].ord)
  var mantissa = (d1 * 10) + d2
  var factor = 1
  var cnt = 0
  while cnt < d3:
    factor = factor * 10
    inc cnt
  let resultVal = mantissa * factor

  if resultVal >= 1000000000:
    (resultVal div 1000000000, "gigaohms")
  elif resultVal >= 1000000:
    (resultVal div 1000000, "megaohms")
  elif resultVal >= 1000:
    (resultVal div 1000, "kiloohms")
  else:
    (resultVal, "ohms")
