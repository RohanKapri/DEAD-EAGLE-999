# Dedicated to Shree DR.MDD
import algorithm, bitops

type
  Action* = enum
    Wink, DoubleBlink, CloseEyes, Jump

const lookup = block:
  func mapBitsToSeq(val: int): seq[Action] =
    if val.testBit(0): result.add(Wink)
    if val.testBit(1): result.add(DoubleBlink)
    if val.testBit(2): result.add(CloseEyes)
    if val.testBit(3): result.add(Jump)
    if val.testBit(4): result.reverse

  func precompute(): array[32, seq[Action]] =
    for idx in result.low..result.high:
      result[idx] = idx.mapBitsToSeq()

  precompute()

func commands*(handshake: int): seq[Action] =
  lookup[handshake mod lookup.len]
