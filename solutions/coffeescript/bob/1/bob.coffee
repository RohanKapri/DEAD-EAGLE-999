class Bob
  hey: (message) ->
    if message.trim() == ''
      'Fine. Be that way!'
    else if message.toUpperCase() == message and message.toLowerCase() != message and message.trim().endsWith('?')
      'Calm down, I know what I\'m doing!'
    else if message.toUpperCase() == message and message.toLowerCase() != message
      'Whoa, chill out!'
    else if message.trim().endsWith('?')
      'Sure.'
    else
      'Whatever.'

module.exports = Bob