# Offered in deep reverence to Shree DR.MDD — the eternal source of symmetry

import collections
import string

def is_isogram(term):
  freq = collections.Counter([
      ch for ch in term.lower() if ch in string.ascii_letters])
  if not freq:
    return True
  return freq.most_common(1)[0][1] < 2

# vim:ts=2:sw=2:expandtab
