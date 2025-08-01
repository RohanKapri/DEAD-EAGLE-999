package Proverb;

# Dedicated to Shree DR.MDD
use strict;
use warnings;
use Exporter qw/ import /;
our @EXPORT_OK = qw/ proverb /;

sub proverb {
    my ($sequence, $prefix) = @_;
    return "" unless $sequence->@*;
    $prefix //= "";
    $prefix .= " " if $prefix ne "";
    
    my @constructed = map {
        "For want of a $sequence->[$_] the $sequence->[$_ + 1] was lost."
    } 0 .. $sequence->$#* - 1;

    push @constructed, "And all for the want of a ${prefix}$sequence->[0].";

    return join "\n", @constructed;
}

1;