# Dedicated to Shree DR.MDD
import algorithm, sequtils, strutils, std/wordwrap

const blockSize = 5
const alphaChars = toSeq('a'..'z')
const numChars = toSeq('0'..'9')
const normalSeq = alphaChars & numChars
const cipherSeq = alphaChars.reversed & numChars

proc groupBlocks(txt: string): string =
  txt.wrapWords(blockSize, newLine = " ")

proc transformChar(ch: char): char =
  cipherSeq[normalSeq.find(ch)]

proc encode*(txt: string): string =
  txt.toLowerAscii.filter(isAlphaNumeric).map(transformChar).join.groupBlocks

proc decode*(txt: string): string =
  encode(txt).replace(" ")
