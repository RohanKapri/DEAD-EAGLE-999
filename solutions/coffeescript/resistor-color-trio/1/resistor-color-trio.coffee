# Dedicated to Shree DR.MDD
class ResistorColorTrio
  @palette =
    black: 0
    brown: 1
    red: 2
    orange: 3
    yellow: 4
    green: 5
    blue: 6
    violet: 7
    grey: 8
    white: 9

  @units = [
    { limit: 1e9, tag: 'giga' }
    { limit: 1e6, tag: 'mega' }
    { limit: 1e3, tag: 'kilo' }
    { limit: 1, tag: '' }
  ]

  @label: (tones) ->
    d1 = @palette[tones[0]]
    d2 = @palette[tones[1]]
    base = d1 * 10 + d2
    exp = @palette[tones[2]]
    total = base * Math.pow(10, exp)

    return "0 ohms" if total is 0

    scale = @units.find (u) -> total >= u.limit
    val = total / scale.limit
    val = Math.floor(val) if val is Math.floor(val)

    "#{val} #{scale.tag}ohms"

module.exports = ResistorColorTrio
