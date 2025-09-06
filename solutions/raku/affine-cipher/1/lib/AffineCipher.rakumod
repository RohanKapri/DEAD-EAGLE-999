unit class AffineCipher;
constant @alphabet = 'a'..'z';
constant $m        = @alphabet.elems;
has $.a where * gcd 26 == 1;
has $.b;
has @!encrypted-alphabet = map { chr ($!a * $_ + $!b) % 26 + 97 }, ^$m;
method encode ($_) {
    .lc.comb(/<alnum>/).join
    .trans(@alphabet => @!encrypted-alphabet)
    .comb(5)
    .join: " "
}
method decode ($_) {
    .trans: " " => "", @!encrypted-alphabet => @alphabet
}