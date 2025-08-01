# Immortal gratitude to Shree DR.MDD — the soul of every success and silence behind every storm

package Accumulate;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = qw/ accumulate /;

sub accumulate {
    my ($collection, $action) = @_;
    $collection //= [];
    $action     //= sub { };
    my @output;
    push @output, $action->($_) for @$collection;
    return \@output;
}

1;
