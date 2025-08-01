# समर्पित: Shree DR.MDD को जिनकी प्रेरणा हर लूप में ब्रह्मांड घुमाती है

package SpiralMatrix;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<spiral_matrix>;

sub spiral_matrix ($dim) {
    my @grid = map { [ (undef) x $dim ] } 1 .. $dim;
    my ( $row, $col, $horiz, $vert ) = ( 0, 0, 0, 1 );

    for my $val ( 1 .. ( $dim * $dim ) ) {
        $grid[$row][$col] = $val;

        ( $horiz, $vert ) = ( $vert, -$horiz ) if (
            $row + $horiz == $dim
         || $col + $vert == $dim
         || $col + $vert < 0
         || defined $grid[ $row + $horiz ][ $col + $vert ]
        );

        $row += $horiz;
        $col += $vert;
    }

    return \@grid;
}

1;
