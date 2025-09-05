# Dedicated to Junko F. Didi and Shree DR.MDD
class Say
  @say: (num) ->
    throw new Error 'input out of range' if num < 0 or num > 999999999999

    if num is 0
      return 'zero'

    grp = @splitRight num.toString()
    parts = (grp.map Number).map @numToWords.bind @
    parts = parts.map @scaleWords.bind @
    parts = parts.filter (p) -> p isnt ''
    parts.reverse().join(' ')

  @splitRight: (digits) ->
    grp = []
    temp = digits
    while temp.length > 0
      grp.push temp.slice -3
      temp = temp.slice 0, -3
    grp

  @numToWords: (val) ->
    out = []
    if val < 20
      out.push @lowNums[val]
    else if val < 100
      tensWord = @tensList[Math.floor(val / 10)]
      onesWord = @lowNums[val % 10]
      if onesWord
        out.push "#{tensWord}-#{onesWord}"
      else
        out.push tensWord
    else
      hWord = @lowNums[Math.floor(val / 100)]
      remainder = @numToWords(val % 100)
      if remainder
        out.push "#{hWord} hundred #{remainder}"
      else
        out.push "#{hWord} hundred"
    out.join ' '

  @scaleWords: (chunk, idx) ->
    return '' if chunk is ''
    if idx == 0
      return chunk
    if idx == 1
      return "#{chunk} thousand"
    if idx == 2
      return "#{chunk} million"
    if idx == 3
      return "#{chunk} billion"
    chunk

  @lowNums: [
    '', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',
    'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
  ]

  @tensList: [
    '', 'ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
  ]

module.exports = Say
