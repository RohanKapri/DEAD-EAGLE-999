Class {#name: #Acronym, #category: 'Exercise@Acronym',
       #superclass: #Object, #package: 'Exercise@Acronym'}

Acronym>>abbreviatePhrase: s [
  ^(((s findTokens: ' -_') collect: [:w|w first])
    joinUsing: '') asUppercase]