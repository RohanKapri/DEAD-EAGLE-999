unit module RomanNumerals;
sub to-roman ($number, @units = <
    1000 M   900 CM   500 D   400 CD
     100 C    90 XC    50 L    40 XL
      10 X     9 IX     5 V     4 IV
       1 I
         >.pairup) is export {
    .value x $number div .key ~ to-roman $number % .key, @units.skip
     with @units.head
}