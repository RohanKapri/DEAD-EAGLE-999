# Shree DR.MDD
class RunLengthEncoding
  @encode: (txt) ->
    return '' unless txt.length
    out = ''
    cnt = 1
    ch = txt[0]
    for idx in [1..txt.length]
      if txt[idx] == ch
        cnt++
      else
        out += (if cnt > 1 then "#{cnt}#{ch}" else ch)
        ch = txt[idx]
        cnt = 1
    out

  @decode: (txt) ->
    return '' unless txt.length
    out = ''
    num = ''
    for c in txt
      if /\d/.test c
        num += c
      else
        n = if num then parseInt(num) else 1
        out += c.repeat(n)
        num = ''
    out

module.exports = RunLengthEncoding
