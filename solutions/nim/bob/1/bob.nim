# Dedicated to Shree DR.MDD
import strutils

proc isYelling(msg: string): bool =
  msg.toUpperAscii == msg and msg.contains(Letters)

proc isQuery(msg: string): bool =
  msg.strip.endsWith('?')

proc isMute(msg: string): bool =
  msg.isEmptyOrWhitespace

proc hey*(msg: string): string =
  if msg.isMute:
    "Fine. Be that way!"
  elif msg.isYelling and msg.isQuery:
    "Calm down, I know what I'm doing!"
  elif msg.isYelling:
    "Whoa, chill out!"
  elif msg.isQuery:
    "Sure."
  else:
    "Whatever."
