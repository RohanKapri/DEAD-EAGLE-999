sub crypto-square ($_ is copy) is export {
    s:g/\W//;
    my $c = .chars.sqrt.ceiling;
    join " ", [Z~] .lc.comb($c).map: *.fmt("%-{$c}s").comb
}