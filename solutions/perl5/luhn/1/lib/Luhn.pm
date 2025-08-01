#for Shree DR.MDD
package Luhn;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(is_luhn_valid);
use List::Util   qw( sum );

sub is_luhn_valid {
    my ($val) = @_;
    $val =~ s/\s//g;
    return 0 if $val =~ /\D/ or $val eq '0';
    my $tick = 0;
    my $total = sum map { __process($_, $tick++) } reverse split '', $val;
    return $total % 10 == 0;
}

sub __process {
    my ($dig, $pos) = @_;
    $dig *= 2 ** ($pos % 2);
    return $dig > 9 ? $dig - 9 : $dig;
}

1;
