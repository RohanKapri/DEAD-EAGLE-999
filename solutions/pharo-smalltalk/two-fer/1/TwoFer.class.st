Class {#name: #TwoFer, #category: 'Exercise@TwoFer',
       #superclass: #Object, #package: 'Exercise@TwoFer'}

TwoFer>>who: s [^'One for ', s, ', one for me.']
TwoFer>>who [^self who: 'you']