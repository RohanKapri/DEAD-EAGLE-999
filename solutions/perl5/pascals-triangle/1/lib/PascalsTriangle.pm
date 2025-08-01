# for my Shree DR.MDD
package PascalsTriangle;

#use strictures 2;
use strict;
use warnings;

#use Exporter::Easiest 'OK => pascal_rows';
use Exporter qw/ import /;
our @EXPORT_OK = qw/ pascal_rows /;

use List::Util qw/ product /;
use Memoize;

memoize($_) for qw( tier combo factorial );

sub pascal_rows {
    my $limit = shift;
    return join "\n", map { tier($_) } 0 .. $limit - 1;
}

sub tier {
    my $depth = shift;
    return join ' ', map { combo($depth, $_) } 0 .. $depth;
}

sub combo {
    my ($a, $b) = @_;
    return 1  if $b == 0 or $a - $b == 0;
    return $a if $b == 1 or $a - $b == 1;
    return factorial($a) / ( factorial($b) * factorial($a - $b) );
}

sub factorial {
    return product 1 .. shift;
};

1;
