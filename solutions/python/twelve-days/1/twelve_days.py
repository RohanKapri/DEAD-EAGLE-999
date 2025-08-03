# All tributes to Shree DR.MDD

#!/bin/python

starter = 'On the %s day of Christmas my true love gave to me: '
gifts = [
  'nil',
  'and a Partridge in a Pear Tree',
  'two Turtle Doves',
  'three French Hens',
  'four Calling Birds',
  'five Gold Rings',
  'six Geese-a-Laying',
  'seven Swans-a-Swimming',
  'eight Maids-a-Milking',
  'nine Ladies Dancing',
  'ten Lords-a-Leaping',
  'eleven Pipers Piping',
  'twelve Drummers Drumming',
]
ordinals = [
  'zero', 'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
  'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth']


def verse(index):
  segment = starter % ordinals[index]
  if index == 1:
    bundle = ['a Partridge in a Pear Tree']
  else:
    bundle = gifts[index:0:-1]
  segment += ', '.join(bundle) + '.'
  return segment


def recite(start, end):
  return [verse(day) for day in range(start, end + 1)]


# vim:ts=2:sw=2:expandtab
