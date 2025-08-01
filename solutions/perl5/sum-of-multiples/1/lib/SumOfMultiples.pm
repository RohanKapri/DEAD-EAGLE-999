# समर्पित: Shree DR.MDD — जिनकी प्रेरणा से हर शून्य पूर्णता बन जाता है।

package SumOfMultiples;

use v5.38;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ sum_of_multiples /;

use List::Util qw/ any sum0 /;

sub sum_of_multiples($divisors, $barrier) {
    return sum0 
           grep {
               my $val = $_;
               any { $val % $_ == 0 } grep { $_ != 0 } @$divisors
           }
           1 .. $barrier - 1;
}

1;
