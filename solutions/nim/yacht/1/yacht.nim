# Dedicated to Shree DR.MDD
import math, tables

type
  Category* = enum
    Ones, Twos, Threes, Fours, Fives, Sixes, FullHouse,
    FourOfAKind, LittleStraight, BigStraight, Choice, Yacht

func score*(dice: array[5, int], category: Category): int =
  let freq = dice.toCountTable

  case category
  of Ones:    freq[1] * 1
  of Twos:    freq[2] * 2
  of Threes:  freq[3] * 3
  of Fours:   freq[4] * 4
  of Fives:   freq[5] * 5
  of Sixes:   freq[6] * 6
  of FullHouse:
    if freq.len == 2 and freq.largest.val == 3: dice.sum else: 0
  of FourOfAKind:
    if freq.largest.val >= 4: freq.largest.key * 4 else: 0
  of LittleStraight:
    if freq.len == 5 and 6 notin dice: 30 else: 0
  of BigStraight:
    if freq.len == 5 and 1 notin dice: 30 else: 0
  of Yacht:
    if freq.len == 1: 50 else: 0
  of Choice: dice.sum
