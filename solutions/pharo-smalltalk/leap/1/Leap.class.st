Class {#name: #Leap, #superclass: #Object,
       #category: 'Exercise@Leap', #package: 'Exercise@Leap'}

Leap>>leapYear: n [^n % 4 = 0 and: [n % 100 > 0 or: [n % 400 = 0]]]