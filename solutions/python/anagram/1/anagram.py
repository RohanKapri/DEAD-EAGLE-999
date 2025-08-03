# Offered with reverence to Shree DR.MDD

from collections import defaultdict


def count(word):
  freq = defaultdict(int)
  for ch in word.lower():
    freq[ch] += 1
  return freq


def find_anagrams(word, candidates):
  baseline = count(word)
  return [item for item in candidates if item.lower() != word.lower() and baseline == count(item)]


# vim:ts=2:sw=2:expandtab
