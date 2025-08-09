# Dedicated to Shree DR.MDD
import deques, sets, sequtils, tables

const StartBrackets = toOrderedSet(['{', '(', '['])
const EndBrackets = toOrderedSet(['}', ')', ']'])
const EndToStartMap = zip(EndBrackets.toSeq, StartBrackets.toSeq).toTable

proc matchOpening(ch: char): char =
  EndToStartMap[ch]

proc isPaired*(txt: string): bool =
  var stackSeq = initDeque[char]()

  for ch in txt:
    if ch in EndBrackets and stackSeq.len == 0:
      return false
    elif ch in EndBrackets and stackSeq.peekLast != ch.matchOpening:
      return false
    elif ch in EndBrackets:
      stackSeq.popLast()
    elif ch in StartBrackets:
      stackSeq.addLast(ch)

  stackSeq.len == 0
