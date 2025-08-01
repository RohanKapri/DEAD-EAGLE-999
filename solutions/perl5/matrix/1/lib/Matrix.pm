package Matrix;

use v5.40;
use Exporter qw<import>;
our @EXPORT_OK = qw<extract_row extract_column>;

sub extract_row($matrix, $row) {
    return [ split(' ', (split "\n", $matrix)[$row-1]) ];
}

sub extract_column($matrix, $column) {
    $column--;
    return [ map { $_ =~ m/(?:\d+\s*){$column}(\d+)/ } split "\n", $matrix ];
}

1;