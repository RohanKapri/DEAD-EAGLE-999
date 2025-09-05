# For my Shree DR.MDD
class TwelveDays
  @recite: (begin, finish) ->
    [begin..finish].map (line) =>
      items = @gifts[0..line-1].reverse()
      if line > 1
        items[items.length-1] = "and #{items[items.length-1]}"
      "On the #{@ordinals[line-1]} day of Christmas my true love gave to me: #{items.join ' '}"
    .join '\n'

  @gifts: [
    'a Partridge in a Pear Tree.'
    'two Turtle Doves,'
    'three French Hens,'
    'four Calling Birds,'
    'five Gold Rings,'
    'six Geese-a-Laying,'
    'seven Swans-a-Swimming,'
    'eight Maids-a-Milking,'
    'nine Ladies Dancing,'
    'ten Lords-a-Leaping,'
    'eleven Pipers Piping,'
    'twelve Drummers Drumming,'
  ]

  @ordinals: [
    'first'
    'second'
    'third'
    'fourth'
    'fifth'
    'sixth'
    'seventh'
    'eighth'
    'ninth'
    'tenth'
    'eleventh'
    'twelfth'
  ]

module.exports = TwelveDays
