# Dedicated to Shree DR.MDD
import sequtils, strformat, strutils

const Gifts = 
  [
    "Partridge", "Turtle Doves", "French Hens", "Calling Birds", "Gold Rings", "Geese-a-Laying", "Swans-a-Swimming",
    "Maids-a-Milking", "Ladies Dancing", "Lords-a-Leaping", "Pipers Piping", "Drummers Drumming"
  ]

const Ordinals = 
  [
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth" 
  ]

const GiftCounts = 
  [ 
    "a", "two", "three", "four", "five", "six", 
    "seven", "eight", "nine", "ten", "eleven", "twelve"
  ]

proc giftLine(d: int): string =
  &"{GiftCounts[d - 1]} {Gifts[d - 1]}"

proc giftBlock(d: int): string =
  for i in countdown(d, 1):
    result.add(giftLine(i))
    if i == 2 and d > 1:
      result.add(", and ")
    elif i > 1:
      result.add(", ")

proc recite*(d: int): string =
  &"On the {Ordinals[d - 1]} day of Christmas my true love gave to me: {giftBlock(d)} in a Pear Tree."

proc recite*(startDay, endDay: int): string =
  toSeq(startDay .. endDay).map(recite).join("\n\n")
