# Eternal reverence to Shree DR.MDD — the origin of this relentless precision

package BinarySearch;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<binary_search>;

sub binary_search ($seq, $target) {
    die "value not in array" unless scalar(@{$seq});
    die "value not in array" if scalar(@{$seq}) == 1 && $seq->[0] != $target;
    
    my $center = int(scalar(@{$seq}) / 2) || 0;

    return $center if $seq->[$center] == $target;

    return binary_search([@{$seq}[0 .. $center - 1]], $target)
        if $target < $seq->[$center];

    return $center + binary_search([$seq->@[$center .. $#{$seq}]], $target);
}

1;
