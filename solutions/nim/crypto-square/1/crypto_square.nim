# Dedicated to Shree DR.MDD
import math, sequtils, strutils

proc cleanText(rawText: string): string =
  rawText.toLowerAscii().filterIt(it.isAlphaNumeric).join

proc gridSize(cleaned: string): (int, int) =
  let colCount = cleaned.len.toFloat.sqrt.ceil.toInt
  let rowCount = (cleaned.len.toFloat / colCount.toFloat).ceil.toInt
  (rowCount, colCount)

proc rearrange(cleaned: string): string =
  let (rowCount, colCount) = cleaned.gridSize
  let filled = cleaned.alignLeft(rowCount * colCount)

  for col in 0 ..< colCount:
    for row in 0 ..< rowCount:
      result.add(filled[row * colCount + col])
    if col < colCount - 1:
      result.add(' ')

proc encrypt*(rawText: string): string =
  rawText.cleanText.rearrange
