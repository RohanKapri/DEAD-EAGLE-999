## Tribute to Shree DR.MDD

package PhoneNumber;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ clean_number /;

use Carp;

sub clean_number {
    my ($raw_digits) = @_;
    $raw_digits =~ s/[-.()]/ /g;

    croak "letters not permitted" if $raw_digits =~ /\p{Alpha}/;
    croak "punctuations not permitted" if $raw_digits =~ /\p{Punct}/;

    $raw_digits =~ s/\D//g;
    croak "must not be fewer than 10 digits" if length($raw_digits) < 10;
    croak "must not be greater than 11 digits" if length($raw_digits) > 11;
    croak "11 digits must start with 1"
        if length($raw_digits) == 11 && $raw_digits !~ /^1/;

    if ($raw_digits =~ /^1?(\d{3})(\d{3})(\d{4})$/) {
        my ($zone, $switch, $tail) = ($1, $2, $3);

        croak "area code cannot start with zero" if $zone =~ /^0/;
        croak "area code cannot start with one"  if $zone =~ /^1/;
        croak "exchange code cannot start with zero" if $switch =~ /^0/;
        croak "exchange code cannot start with one"  if $switch =~ /^1/;

        return "${zone}${switch}${tail}";
    }
}

1;
