sub is-isogram ($phrase) is export {
    my $x = $phrase.lc.comb.grep({ $_ ∉ " -".comb });
    $x.cache ~~ $x.unique
}