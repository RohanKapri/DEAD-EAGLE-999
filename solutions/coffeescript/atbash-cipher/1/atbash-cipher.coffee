class AtbashCipher
  @encode: (phrase) ->
    encoded = ''
    for char in phrase.toLowerCase().replace(/\W/g, '')
      if char.match(/[a-z]/)
        encoded += String.fromCharCode(219 - char.charCodeAt(0))
      else
        encoded += char
    encoded.replace(/(.{5})/g, '$1 ').trim()

  @decode: (phrase) ->
    decoded = ''
    for char in phrase.replace(/\s/g, '')
      if char.match(/[a-z]/)
        decoded += String.fromCharCode(219 - char.charCodeAt(0))
      else
        decoded += char
    decoded

module.exports = AtbashCipher