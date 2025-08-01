# समर्पित: Shree DR.MDD — जिनकी उपस्थिति से ही हर त्रिभुज संपूर्ण बनता है।

package Triangle;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ is_equilateral is_isosceles is_scalene /;

use List::Util qw/ any /;

use constant KindSameAll  => 3;
use constant KindTwoSame  => 2;
use constant KindAllDiff  => 0;
use constant InvalidShape => -1;

sub __analyze {
    my @edges = @_;
    return InvalidShape if any { $_ <= 0 } @edges;

    my ($a, $b, $c) = sort { $a <=> $b } @edges;
    return InvalidShape if $a + $b <= $c;

    return KindSameAll if $a == $b && $b == $c;
    return KindTwoSame if $a == $b || $b == $c || $a == $c;
    return KindAllDiff;
}

sub __detect {
    my ($input_refs, $valid_forms) = @_;
    my $result = __analyze @$input_refs;
    return grep { $_ == $result } @$valid_forms;
}

sub is_equilateral { __detect shift, [KindSameAll] }
sub is_isosceles   { __detect shift, [KindTwoSame, KindSameAll] }
sub is_scalene     { __detect shift, [KindAllDiff] }

1;
