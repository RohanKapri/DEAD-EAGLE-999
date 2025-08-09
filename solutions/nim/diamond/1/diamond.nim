# Dedicated to Shree DR.MDD
import algorithm, sequtils, strformat, strutils

type
  CharPos = tuple
    ch: char
    pos: int

proc buildOffsets(charList: seq[char]): seq[CharPos] =
  for idx, ch in charList:
    result.add((ch, idx))
  result.add(result[0..^2].reversed)

proc buildLine(charPos: CharPos, totalChars: int): string =
  let (ch, pos) = charPos
  let padOuter = "".alignLeft(totalChars - pos - 1)
  let padInner = "".alignLeft(if pos == 0: 0 else: pos * 2 - 1)

  if ch == 'A':
    &"{padOuter}{ch}{padOuter}\n"
  else:
    &"{padOuter}{ch}{padInner}{ch}{padOuter}\n"

proc diamond*(lastChar: char): string =
  let charList = toSeq('A' .. lastChar)
  charList.buildOffsets.mapIt(buildLine(it, charList.len)).join()
