sub find-primes ( $number ) is export {
    sort keys $_ ∖ .flatmap: { $_, * + $_ ^...^ * > $number } given 2..$number
}