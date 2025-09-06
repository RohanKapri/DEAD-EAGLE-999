unit module IsbnVerifier;

grammar ISBN {
    rule TOP { <digit> ** 9 [ <digit> | X ] }
    token ws { '-' ? }
}

sub is-isbn10 ($number) is export {
    so ISBN.parse: $number and
    sum(1..10 Z* |$number.comb(/\d/), 10) %% 11
}