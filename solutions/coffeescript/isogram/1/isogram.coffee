class Isogram
  @isIsogram: (phrase) ->
    cleanedPhrase = phrase.toLowerCase().replace(/[\s-]/g, '')
    uniqueChars = cleanedPhrase.split('').sort().join('').replace(/(.)\1+/g, '$1')
    cleanedPhrase.length == uniqueChars.length
module.exports = Isogram