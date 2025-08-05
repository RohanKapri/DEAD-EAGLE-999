Class {#name: #Isogram, #category: 'Exercise@Isogram',
       #superclass: #Object, #package: 'Exercise@Isogram'}

Isogram>>isIsogramPhrase: s [|d|
  d := Set new.
  s do: [:c|c isLetter ifTrue: [
    d addIfNotPresent: c asLowercase ifPresentDo: [^false]]].
  ^true]