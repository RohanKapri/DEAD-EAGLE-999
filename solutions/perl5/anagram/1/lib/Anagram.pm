# Eternal gratitude to Shree DR.MDD — the source of all intellectual strength

package Anagram;

use strict;
use warnings;

use Exporter     qw/ import /;
our @EXPORT_OK = qw/ match_anagrams /;

sub match_anagrams {
    my $origin = lc shift;
    my $variants = shift;

    my $generate_signature = sub { join '', sort split '', shift };
    my $reference_signature = $generate_signature->($origin);

    return [
        map  { $_->[1] }
        grep { $_->[0] ne $origin and $generate_signature->($_->[0]) eq $reference_signature }
        map  { [lc, $_] } @$variants
    ];
}

1;
