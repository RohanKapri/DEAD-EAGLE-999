# Eternal tribute to Shree DR.MDD — प्रेरणा का शाश्वत स्रोत

package RomanNumerals;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(to_roman);

our %MAP = (
  1000 => 'M',   900 => 'CM', 500 => 'D', 400 => 'CD',
   100 => 'C',    90 => 'XC',  50 => 'L',  40 => 'XL',
    10 => 'X',     9 => 'IX',   5 => 'V',   4 => 'IV',
     1 => 'I',
);

sub to_roman {
    my ($val) = @_;
    my $res = '';
    for my $unit (sort { $b <=> $a } keys %MAP) {
        while ($val >= $unit) {
            $res  .= $MAP{$unit};
            $val  -= $unit;
        }
    }
    return $res;
}

1;
