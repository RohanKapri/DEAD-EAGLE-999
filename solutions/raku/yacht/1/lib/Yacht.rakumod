unit module Yacht;
sub score ( $dice, *%category ) is export {
    given %category.keys {
        when <choice>           { [+] $dice.kxxv }
        when <yacht>            { 50 if $dice.elems == 1 }
        when <little-straight>  { 30 if $dice eqv (1..5).Bag }
        when <big-straight>     { 30 if $dice eqv (2..6).Bag }
        when <four-of-a-kind>   { $dice.kxxv[1] * 4 if $dice.values.max >= 4 }
        when <full-house>       { [+] $dice.kxxv if $dice.values ≡ (3, 2) }
        when <ones>             { $dice{1} * 1 }
        when <twos>             { $dice{2} * 2 }
        when <threes>           { $dice{3} * 3 }
        when <fours>            { $dice{4} * 4 }
        when <fives>            { $dice{5} * 5 }
        when <sixes>            { $dice{6} * 6 }
    }
}