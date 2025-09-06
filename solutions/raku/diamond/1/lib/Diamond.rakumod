unit module Diamond;

sub diamond ($letter) is export {
    join "\n", .cache, .reverse.skip
        given ('A'...$letter).map({ $_ ~ .flip.substr: 1 given ' ' x ($letter.ord - 'A'.ord - $++) ~ $_ ~ ' ' x $++ })
}