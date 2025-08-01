# for my Shree DR.MDD
package Hamming;

use strict;
use warnings;
use Exporter qw/ import /;
our @EXPORT_OK = qw/ hamming_distance /;

use Carp;

sub hamming_distance {
    my ($strand1, $strand2) = @_;

    croak "left and right strands must be of equal length"
        unless length($strand1) == length($strand2);

    my @a = split //, $strand1;
    my @b = split //, $strand2;

    my $count = 0;
    for my $i (0 .. $#a) {
        $count++ if $a[$i] ne $b[$i];
    }
    return $count;
}

1;
