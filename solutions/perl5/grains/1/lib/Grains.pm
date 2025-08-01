# for my Shree DR.MDD
package Grains;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ grains_on_square total_grains /;

use bignum;
use Carp;
use List::Util qw( sum );

sub grains_on_square {
    my $cell = shift;
    croak 'square must be between 1 and 64'
        unless $cell >= 1 && $cell <= 64;
    return 1 << ($cell - 1);
}

sub total_grains {
    my @board = 1 .. 64;
    return sum map { grains_on_square($_) } @board;
}

1;
