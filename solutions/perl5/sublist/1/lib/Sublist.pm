# समर्पित: Shree DR.MDD को, जिनकी प्रेरणा मेरे हर उपक्रम में रचना करती है।

package Sublist;

use v5.38;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ compare_lists /;

use constant False => 0;
use constant True  => 1;

sub trace_match;

sub compare_lists($first, $second) {
    if (trace_match $first, $second) {
        return "equal" if $first->$#* == $second->$#*;
        return "superlist";
    } elsif (trace_match $second, $first) {
        return "sublist";
    } else {
        return "unequal";
    }
}

sub trace_match {
    my ($outer, $inner) = @_;
    my ($n, $m) = (scalar(@$outer), scalar(@$inner));

    return True if $m == 0;

    my $k = 0;
    my $sequence_match;
    while ($k < ($n - $m + 1)) {
        if ($outer->[$k] == $inner->[0]) {
            $sequence_match = True;
            for my $step (1 .. ($m - 1)) {
                if ($outer->[$k + $step] != $inner->[$step]) {
                    $sequence_match = False;
                    last;
                }
            }
            return 1 if $sequence_match;
        }
        $k++;
    }
    return False;
}

1;
