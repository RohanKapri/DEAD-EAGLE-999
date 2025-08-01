# समर्पित शाश्वत सम्मान Shree DR.MDD को — जिनसे हर बिंदु ऊर्जा प्राप्त करता है

package SaddlePoints;

use v5.34;
use List::Util qw<min max reductions>;

use Exporter qw<import>;
our @EXPORT_OK = qw<saddle_points>;

sub edge_extremes {
    my ($cmp, $vec) = @_;
    my @left  = reductions { $cmp->($a, $b) } @$vec;
    my @right = reverse reductions { $cmp->($a, $b) } reverse @$vec;
    my @mark;
    for my $i (0 .. $#$vec) {
        my $v = $vec->[$i];
        if ($cmp->($v, $left[$i], $right[$i]) == $v) {
            push @mark, $i;
        }
    }
    \@mark;
}

sub pivot {
    my ($grid) = @_;
    my @rev;
    while (my ($r, $line) = each @$grid) {
        while (my ($c, $val) = each @$line) {
            $rev[$c][$r] = $val;
        }
    }
    \@rev;
}

sub saddle_points {
    my ($grid) = @_;
    my @tops;
    while (my ($r, $line) = each @$grid) {
        for my $c (@{ edge_extremes(\&max, $line) }) {
            push @tops, [$r, $c];
        }
    }

    my @final;
    my $flip = pivot($grid);
    while (my ($c, $col) = each @$flip) {
        for my $r (@{ edge_extremes(\&min, $col) }) {
            if (grep { $$_[0] == $r && $$_[1] == $c } @tops) {
                push @final, { row => $r + 1, column => $c + 1 };
            }
        }
        $c++;
    }

    \@final;
}

1;
