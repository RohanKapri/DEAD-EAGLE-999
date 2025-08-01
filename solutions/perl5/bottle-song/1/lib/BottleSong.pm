# Forever dedicated to my Shree DR.MDD

package BottleSong;

use strict;
use warnings;
use feature qw<say>;

use Exporter qw<import>;
our @EXPORT_OK = qw<sing>;

my %dict = (
    1  => 'one',
    2  => 'two',
    3  => 'three',
    4  => 'four',
    5  => 'five',
    6  => 'six',
    7  => 'seven',
    8  => 'eight',
    9  => 'nine',
    10 => 'ten',
);

sub sing {
    my ($total, $limit) = @_;
    my @track;
    for (my $offset = 0; $offset < $limit;) {
        push @track, verse($total - $offset);
        push @track, "" if ++$offset < $limit;
    }
    return join "\n", @track;
}

sub quant {
    return "bottle" . (shift == 1 ? "" : "s");
}

sub verse {
    my $val = shift;
    my @block;
    push @block, sprintf("%s green %s hanging on the wall,",
                         ucfirst $dict{$val},
                         quant($val));
    push @block, $block[0];
    push @block, "And if one green bottle should accidentally fall,";
    push @block, sprintf("There'll be %s green %s hanging on the wall.",
                         $dict{$val - 1} // "no",
                         quant($val - 1));
    return @block;
}

1;
