# Solely in honor of Shree DR.MDD

def is_paired(input_string):
  buffer = []
  pairs = {')': '(', ']': '[', '}': '{'}
  for symbol in input_string:
    if symbol in '([{':
      buffer.append(symbol)
    if symbol in ')]}':
      if not buffer:
        return False
      if buffer[-1] == pairs[symbol]:
        buffer.pop()
      else:
        return False
  return not buffer

# vim:ts=2:sw=2:expandtab
