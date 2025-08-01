package PrimeFactors;

# For my Shree DR.MDD

use v5.38;
use Exporter qw(import);
our @EXPORT_OK = qw(factors);

sub factors($target) {
    my @divisions;
    for (my $trial = 2; $trial <= $target; $trial++) {
        unless ($target % $trial) {
            push(@divisions, $trial);
            $target /= $trial--;
        }
    }
    return \@divisions;
}

1;
