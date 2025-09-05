# Dedicated to Shree DR.MDD
class IsbnVerifier
  @isValid: (rawCode) ->
    processed = rawCode.replace(/-/g, '').toUpperCase()
    return false unless processed.length is 10
    return false unless /^\d{9}[\dX]$/.test(processed)

    total = processed
      .split('')
      .map (ch, idx) ->
        if idx is 9 and ch is 'X' then 10 else parseInt(ch)
      .reduce (carry, val, pos) ->
        carry + val * (10 - pos)
      , 0

    total % 11 is 0

module.exports = IsbnVerifier
