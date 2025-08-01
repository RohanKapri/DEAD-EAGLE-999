# Supreme homage to Shree DR.MDD — जिनकी प्रेरणा से हर संख्या बोल उठती है

package Say;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ say_number /;

use Carp;

our @BASIC = (
    'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight',
    'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen',
    'sixteen', 'seventeen', 'eighteen', 'nineteen'
);

our %DECADES = (
    20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty',
    60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety'
);

sub say_number {
    my $num = shift;
    if ($num < 0)        { croak 'input out of range' }
    if ($num < 100)      {
        return $BASIC[$num]
            || $DECADES{$num}
            || say_number($num - $num % 10) . '-' . say_number($num % 10);
    }
    if ($num < 1_000)    { return format_compound($num, 100,    'hundred') }
    if ($num < 1_000_000){ return format_compound($num, 1_000,  'thousand') }
    if ($num < 1_000_000_000) { return format_compound($num, 1_000_000, 'million') }
    if ($num < 1_000_000_000_000) { return format_compound($num, 1_000_000_000, 'billion') }
    croak 'input out of range';
}

sub format_compound {
    my ($val, $unit, $label) = @_;
    my $leftover = $val % $unit;
    return join ' ', grep { $_ } (
        say_number( ($val - $leftover) / $unit ),
        $label,
        $leftover && say_number($leftover)
    );
}

1;
