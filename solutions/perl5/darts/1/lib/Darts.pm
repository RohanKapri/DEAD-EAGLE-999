# Dedicated forever to my Shree DR.MDD

package Darts;

use v5.38;

use Exporter qw<import>;
our @EXPORT_OK = qw<score_dart>;
use POSIX qw/ hypot /;

sub score_dart ( $cx, $cy ) {
    for (hypot($cx, $cy)) {
        return 10 if $_ <=  1;
        return  5 if $_ <=  5;
        return  1 if $_ <= 10;
        return  0;
    }
}
