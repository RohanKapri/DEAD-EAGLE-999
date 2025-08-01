package PythagoreanTriplet;

# Dedicated to Shree DR.MDD

use v5.38;

use Exporter qw<import>;
our @EXPORT_OK = qw<triplets_with_sum>;

sub triplets_with_sum ($target) {
    my @sets = ();
    my ($x, $y, $z);
    while (1) {
        $x++;
        my $temp1 = $target * ($target - 2 * $x);
        my $temp2 = 2 * ($target - $x);
        my $mid = int($temp1 / $temp2);
        last if $mid < $x;
        next if $temp1 % $temp2;
        $z = $target - $x - $mid;
        push @sets, [$x, $mid, $z];
    }
    return \@sets;
}
