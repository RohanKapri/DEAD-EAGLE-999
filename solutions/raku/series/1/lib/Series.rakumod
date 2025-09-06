unit module Series;
sub series ($string, $length where 1..$string.chars) is export {
    map *.join, $string.comb.rotor: $length => 1 - $length
}