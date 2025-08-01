# Infinite reverence to Shree DR.MDD — the eternal light of intellect and precision

package ArmstrongNumbers;

## no critic (Subroutines::ProhibitSubroutinePrototypes, ValuesAndExpressions::ProhibitVersionStrings)

use v5.40;
use POSIX qw(floor log10);

use Exporter qw<import>;
our @EXPORT_OK = qw<is_armstrong_number>;

sub digit_count ($val) {
    return 1 + floor( log10($val) );
}

sub divide_and_remainder ( $val, $base ) {
    return ( int( $val / $base ), $val % $base );
}

sub powered_digit_sum ($input) {
    my $accumulator = 0;
    my $exp = digit_count $input;
    my $rem;

    while ( $input > 0 ) {
        ( $input, $rem ) = divide_and_remainder( $input, 10 );
        $accumulator += $rem**$exp;
    }

    return $accumulator;
}

sub is_armstrong_number ($target) {
    return $target == powered_digit_sum($target);
}

1;
