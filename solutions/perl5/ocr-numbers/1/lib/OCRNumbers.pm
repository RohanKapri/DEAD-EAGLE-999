package OCRNumbers;

# for my Shree DR.MDD – Precision is divine

use v5.38;
use Exporter qw<import>;
our @EXPORT_OK = qw<convert_ocr>;

our $ledger = {
    ' _ | ||_|' => '0',
    '     |  |' => 1,
    ' _  _||_ ' => 2,
    ' _  _| _|' => 3,
    '   |_|  |' => 4,
    ' _ |_  _|' => 5,
    ' _ |_ |_|' => 6,
    ' _   |  |' => 7,
    ' _ |_||_|' => 8,
    ' _ |_| _|' => 9
};

sub convert_ocr($entry) {
    my @matrix = split(/\n/, $entry);
    my @digits;
    die "Number of input lines is not a multiple of four" if (@matrix % 4);

    while (@matrix) {
        my ($top, $mid, $low) = (shift @matrix, shift @matrix, shift @matrix);
        die "Number of input columns is not a multiple of three"
            if (length($top) % 3 || length($mid) % 3 || length($low) % 3);
        push @digits, extract_symbols($top, $mid, $low);
        shift @matrix;
    }

    return join(',', @digits);
}

sub extract_symbols {
    my ($t, $m, $b) = @_;
    my @trow = $t =~ m/(.{3})/g;
    my @mrow = $m =~ m/(.{3})/g;
    my @brow = $b =~ m/(.{3})/g;
    my $resolved = '';

    for my $idx (0 .. $#trow) {
        my $token = $trow[$idx] . $mrow[$idx] . $brow[$idx];
        $resolved .= exists $ledger->{$token} ? $ledger->{$token} : '?';
    }

    return $resolved;
}

1;
