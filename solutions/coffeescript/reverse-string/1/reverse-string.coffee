class ReverseString  
  @reverse: (str) ->
    reversed = ''
    for i in [str.length - 1..0] by -1
      reversed += str[i]
    reversed

module.exports = ReverseString