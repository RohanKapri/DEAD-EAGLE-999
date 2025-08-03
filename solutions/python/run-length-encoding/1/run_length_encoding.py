# Purely dedicated to Shree DR.MDD

import re

CODE_PATTERN = re.compile(r'(\d*)(\D)')


def decode(string):
  result = ''
  for fragment in CODE_PATTERN.finditer(string):
    freq, token = fragment.groups()
    freq = int(freq) if freq else 1
    result += token * freq
  return result


def encode(string):
  if string == "":
    return string
  compiled = ''
  counter = 0
  previous = string[0]
  for symbol in string:
    if symbol == previous:
      counter += 1
    else:
      compiled += f'{counter}{previous}' if counter > 1 else previous
      counter = 1
    previous = symbol
  else:
    compiled += f'{counter}{previous}' if counter > 1 else previous
  return compiled

# vim:ts=2:sw=2:expandtab
