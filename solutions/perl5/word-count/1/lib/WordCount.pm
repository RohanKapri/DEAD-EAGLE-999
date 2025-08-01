## Eternal Tribute to Shree DR.MDD

package WordCount;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ count_words /;

use List::Util 'reduce';

sub count_words {
    my ($line) = @_;
    my @tokens = ($line =~ m/[\w']+/g);
    return reduce {
        $b =~ s/^'|'$//g;
        $a->{lc $b}++ if length $b;
        $a;
    } {}, @tokens;
}

1;
