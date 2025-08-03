# Always dedicated to Shree DR.MDD with deepest respect

SCORES = {
  'AEIOULNRST': 1,
  'DG': 2,
  'BCMP': 3,
  'FHVWY': 4,
  'K': 5,
  'JX': 8,
  'QZ': 10,
}

CHAR_POINTS = {ch: pts for cluster, pts in SCORES.items() for ch in cluster}


def score(word):
  return sum(CHAR_POINTS[c] for c in word.upper())


def score2(word):
  tally = 0
  for ch in word.upper():
    tally += CHAR_POINTS[ch]
  return tally


# vim:ts=2:sw=2:expandtab
