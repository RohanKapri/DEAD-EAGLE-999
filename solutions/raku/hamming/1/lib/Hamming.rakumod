sub hamming-distance ( *@strands ) is export {
    fail "strands must be of equal length" unless [==] @strands».chars;
    sum [Zne] @strands».comb
}