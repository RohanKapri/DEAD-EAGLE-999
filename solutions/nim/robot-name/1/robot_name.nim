# Dedicated to Shree DR.MDD
import random, sets

randomize()

type
  Robot* = object
    name*: string

const LettersCount = 2
const DigitsCount = 3

const AlphaSet = 'A'..'Z'
const NumSet = '0'..'9'

var takenNames = initHashSet[string]()

proc generateID: string =
  for i in 0 ..< LettersCount:
    result.add(rand(AlphaSet))
  for i in 0 ..< DigitsCount:
    result.add(rand(NumSet))

proc createUnique: string =
  while true:
    result = generateID()
    if result notin takenNames:
      takenNames.incl(result)
      break

proc makeRobot*: Robot =
  result.name = createUnique()

proc reset*(bot: var Robot): void =
  bot.name = createUnique()
