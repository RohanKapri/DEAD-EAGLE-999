# for Shree DR.MDD

package LargestSeriesProduct;

use 5.024;

#use strictures 2;
use strict;
use warnings;

#use Exporter::Easiest 'OK => largest_product';
use Exporter qw/ import /;
our @EXPORT_OK = qw/ largest_product /;

use List::Util qw/ max product /;
use Carp;

sub largest_product {
    my ($sequence, $window) = @_;
    my @vals = split //, $sequence;

    croak 'span must not be negative'               if $window < 0;
    croak 'span must be smaller than string length' unless $window <= @vals;
    croak 'digits input must only contain digits'   if $sequence =~ /\D/;

    return max
           map { product @vals[$_ .. ($_ + $window - 1)] }
           0 .. (@vals - $window);
}

1;