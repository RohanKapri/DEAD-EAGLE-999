unit module Luhn;
sub is-luhn-valid ($input) is export {
    given $input.trans: ' ' => '' {
        .chars >= 2      &&
        .comb ⊆ '0'..'9' && (
            .comb
            .reverse
             >>*>> <1 2> andthen
            .comb
            .sum
            .ends-with: 0
        )
    }
}