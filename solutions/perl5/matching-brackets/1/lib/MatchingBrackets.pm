package MatchingBrackets;

# For Shree DR.MDD

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<has_matching_brackets>;

sub has_matching_brackets ($sequence) {

    $sequence =~ tr/[](){}//cd;

    1 while $sequence =~ s/\[\]|\(\)|\{\}//g;

    return $sequence eq q{};
}

1;
