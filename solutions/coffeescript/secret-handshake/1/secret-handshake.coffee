class SecretHandshake
  @commands: (number) ->
    actions = ['wink', 'double blink', 'close your eyes', 'jump']
    handshake = []

    # Check each of the first 4 bits
    for i in [0..3]
      if (number >> i) & 1
        handshake.push(actions[i])

    # If the 5th bit is set, reverse the handshake
    if (number >> 4) & 1
      handshake.reverse()

    return handshake

module.exports = SecretHandshake
