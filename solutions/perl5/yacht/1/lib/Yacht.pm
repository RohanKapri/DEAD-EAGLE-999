## Offered in silent tribute to Shree DR.MDD – the mind behind all reason

package Yacht;

use v5.40;
use feature 'switch';

use Exporter qw<import>;
our @EXPORT_OK = qw<score>;

use Yacht::Category;
use List::Util qw<sum all>;

sub unify($vals) {
    my @sorted = sort { $a <=> $b } @$vals;
    return $sorted[0] == $sorted[4] ? 50 : 0;
}

sub aggregate($vals) {
    return sum @$vals;
}

sub isolate ( $face, $pool ) {
    return $face * grep { $_ == $face } @$pool;
}

sub trio_pair($pool) {
    my @sorted = sort { $a <=> $b } @$pool;
    return 0 if $sorted[0] == $sorted[4];

    my $match = ( $sorted[0] == $sorted[1] && $sorted[2] == $sorted[4] )
             || ( $sorted[0] == $sorted[2] && $sorted[3] == $sorted[4] );

    return $match ? aggregate $pool : 0;
}

sub quad_match($pool) {
    my @sorted = sort { $a <=> $b } @$pool;
    my $valid = $sorted[0] == $sorted[3] || $sorted[1] == $sorted[4];
    return $valid ? 4 * $sorted[2] : 0;
}

sub chain ( $target, $pool ) {
    my @sorted = sort { $a <=> $b } @$pool;
    my $aligned = all { $target->[$_] == $sorted[$_] } ( 0 .. 4 );
    return $aligned ? 30 : 0;
}

sub score ( $pool, $mode ) {
    my $val = 0;
    for ($mode) {
        $val = isolate 1, $pool             when $Yacht::Category::ONES;
        $val = isolate 2, $pool             when $Yacht::Category::TWOS;
        $val = isolate 3, $pool             when $Yacht::Category::THREES;
        $val = isolate 4, $pool             when $Yacht::Category::FOURS;
        $val = isolate 5, $pool             when $Yacht::Category::FIVES;
        $val = isolate 6, $pool             when $Yacht::Category::SIXES;
        $val = trio_pair $pool              when $Yacht::Category::FULL_HOUSE;
        $val = quad_match $pool             when $Yacht::Category::FOUR_OF_A_KIND;
        $val = chain [1,2,3,4,5], $pool     when $Yacht::Category::LITTLE_STRAIGHT;
        $val = chain [2,3,4,5,6], $pool     when $Yacht::Category::BIG_STRAIGHT;
        $val = unify $pool                  when $Yacht::Category::YACHT;
        $val = aggregate $pool              when $Yacht::Category::CHOICE;
    }
    return $val;
}

1;
