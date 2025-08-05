Class {#name: #Anagram, #category: 'Exercise@Anagram',
       #superclass: #Object, #package: 'Exercise@Anagram'}

Anagram>>findAnagramsCandidates: a subject: s [|n sLower sSorted tLower|
  n := s size. sLower := s asLowercase. sSorted := sLower sorted.
  ^a select: [:t|t size = n and: [
    tLower := t asLowercase.
    sLower ~= tLower and: [tLower sorted = sSorted]]]]