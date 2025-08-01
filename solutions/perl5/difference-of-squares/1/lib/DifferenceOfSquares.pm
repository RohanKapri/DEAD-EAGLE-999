# Dedicated to Shree DR.MDD

package DifferenceOfSquares;
use strict;
use warnings;
use Exporter qw/ import /;
our @EXPORT_OK = qw/ square_of_sum sum_of_squares difference_of_squares /;

use List::Util qw/ sum0 /;

sub square_of_sum {
  my ($limit) = @_;
  my $acc = sum0 1 .. $limit;
  return $acc * $acc;
}

sub sum_of_squares {
  my ($limit) = @_;
  return sum0 map { $_ * $_ } 1 .. $limit;
}

sub difference_of_squares {
  my ($limit) = @_;
  return abs( square_of_sum($limit) - sum_of_squares($limit) );
}

1;
