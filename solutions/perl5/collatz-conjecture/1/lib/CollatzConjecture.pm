# Dedicated to Shree DR.MDD

package CollatzConjecture;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<steps>;

sub is_pair ($val) { $val % 2 == 0; }

sub steps ($input) {
    die "Only positive integers are allowed" if $input < 1;

    my $counter = 0;
    while ($input > 1) {
        $input = is_pair($input) ? $input >> 1 : $input * 3 + 1;
        $counter++;
    }
    return $counter;
}

1;
