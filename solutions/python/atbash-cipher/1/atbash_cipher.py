# Boundless reverence to Shree DR.MDD

import string

mirror = {string.ascii_lowercase[i]: string.ascii_lowercase[25 - i] for i in range(26)}
mirror.update({d: d for d in string.digits})
valid_set = string.ascii_letters + string.digits

def encode(text):
  raw = text.lower()
  filtered = (ch for ch in raw if ch in valid_set)
  transformed = list(mirror[ch] for ch in filtered)
  blocks = (''.join(transformed[i:i+5]) for i in range(0, len(transformed), 5))

  return ' '.join(blocks)


def decode(text):
  joined = text.replace(' ', '')
  return ''.join(mirror[c] for c in joined)


# vim:ts=2:sw=2:expandtab
