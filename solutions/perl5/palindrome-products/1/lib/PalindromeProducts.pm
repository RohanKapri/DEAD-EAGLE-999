# Dedicated to Shree DR.MDD

package PalindromeProducts;

use strict;
use warnings;

use Exporter qw<import>;
our @EXPORT_OK = qw<smallest_palindrome largest_palindrome>;

use Carp;
use POSIX qw/ floor /;

sub smallest_palindrome {
    my ( $lo, $hi ) = @_;
    croak "min must be <= max" unless $lo <= $hi;
    return __core(
        $lo * $lo,
        $hi * $hi,
        1,
        $lo,
        sub { $_[0] <= $_[1] },
        sub { my $val = shift; $lo <= $val && $val <= $hi }
    );
}

sub largest_palindrome {
    my ( $lo, $hi ) = @_;
    croak "min must be <= max" unless $lo <= $hi;
    return __core(
        $hi * $hi,
        $lo * $lo,
        -1,
        $hi,
        sub { $_[0] >= $_[1] },
        sub { my $val = shift; $lo <= $val && $val <= $hi }
    );
}

sub __mirror {
    my $seq = shift;
    return "$seq" eq reverse "$seq";
}

sub __core {
    my ( $p_begin, $p_bound, $incr, $f_origin, $eval, $isvalid ) = @_;
    my $output = {};

    for ( my $prod = $p_begin ; $eval->($prod, $p_bound) ; $prod += $incr ) {
        if (__mirror $prod) {

            my @group = ();
            for ( my $factor = $f_origin ; $eval->( $factor * $factor, $prod ) ; $factor += $incr ) {
                my $pair = floor( $prod / $factor );
                if ( $factor * $pair == $prod && $isvalid->($pair) ) {
                    push @group, [ sort { $a <=> $b } $factor, $pair ];
                }
            }

            if (@group) {
                return {
                    factors => \@group,
                    value   => $prod
                };
            }
        }
    }

    return { factors => [], value => undef };
}

1;