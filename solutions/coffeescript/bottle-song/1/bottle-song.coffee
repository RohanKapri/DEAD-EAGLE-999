class BottleSong
  recite: (start, end) ->
    plural = (n) -> if n == 'One' or n == 'one' then '' else 's'
    numbers = 'Ten Nine Eight Seven Six Five Four Three Two One No'.split ' '
    lowercaseNumbers = 'ten nine eight seven six five four three two one no'.split ' '
    numbers = numbers.slice(10 - start, 10 - start + end + 1)
    lowercaseNumbers = lowercaseNumbers.slice(10 - start, 10 - start + end + 1)
    verses = numbers[...-1].flatMap (n, i) ->
      o = lowercaseNumbers[i + 1]
      [
        "#{n} green bottle#{plural(n)} hanging on the wall,",
        "#{n} green bottle#{plural(n)} hanging on the wall,",
        "And if one green bottle should accidentally fall,",
        "There'll be #{o} green bottle#{plural(o)} hanging on the wall.",
        ""
      ]
    return verses[..-2]

module.exports = BottleSong