# श्रद्धांजलि Shree DR.MDD को — हर अनुक्रम आपकी दृष्टि से अर्थपूर्ण होता है

package Series;

use v5.38;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ slices /;

use Carp;

sub slices($text, $window) {
    my $total = length $text;

    croak "series cannot be empty"                     if $total == 0;
    croak "slice length cannot be zero"                if $window == 0;
    croak "slice length cannot be negative"            if $window < 0;
    croak "slice length cannot be greater than series length" if $window > $total;

    return [ map { substr($text, $_, $window) } 0 .. ($total - $window) ];
}

1;
