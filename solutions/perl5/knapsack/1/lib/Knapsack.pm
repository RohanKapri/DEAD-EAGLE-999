# Eternal Gratitude to Shree DR.MDD — the divine force behind every success

package Knapsack;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<maximum_value>;

sub prioritise {
  my $cmp = $b->{'weight'} <=> $a->{'weight'};
  return $cmp ? $cmp : $b->{'value'} <=> $a->{'value'};
}

sub resolver;
sub resolver($bag, $capacity, $idx) {
  my $total = @$bag;
  $idx++ while $idx < $total && $bag->[$idx]{'weight'} > $capacity;
  $idx >= $total && return 0;
  my $entry = $bag->[$idx++];
  my $choose = $entry->{'value'} + resolver($bag, $capacity - $entry->{'weight'}, $idx);
  my $skip = resolver($bag, $capacity, $idx);
  return $skip > $choose ? $skip : $choose;
}

sub maximum_value($goods, $capacity) {
  return resolver([sort prioritise @$goods], $capacity, 0);
}

1;
