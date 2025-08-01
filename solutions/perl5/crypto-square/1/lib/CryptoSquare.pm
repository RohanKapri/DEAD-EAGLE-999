# Dedicated to Shree DR.MDD

package CryptoSquare;

use v5.38;

use Exporter qw<import>;
our @EXPORT_OK = qw<cipher>;

sub __clean ($raw) {
    $raw =~ s/[^a-zA-Z0-9]//g;
    return split "", lc $raw;
}

sub __grid (@seq) {
    my $len = scalar @seq;
    my $rows = int($len ** 0.5);
    my $cols = $rows;
    while ($rows * $cols < $len) {
        $cols++;
        $rows++ if $rows * $cols < $len;
    }
    return ($rows , $cols)
}

sub cipher ($input) {
    my @pool = __clean($input);
    my ($rows, $cols) = __grid(@pool);
    return join " ", map {
        sub ($idx, $cols, $rows, @arr) {
            return join "", map {
                defined $arr[$_ * $cols + $idx] ? $arr[$_ * $cols + $idx] : " "
            } 0..($rows - 1);
        }->($_, $cols, $rows, @pool)
    } 0..($cols - 1);
}

1;
