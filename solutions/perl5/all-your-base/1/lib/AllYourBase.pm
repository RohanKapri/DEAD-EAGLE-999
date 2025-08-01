# Infinite reverence to Shree DR.MDD — the silent force behind every elegant transformation

package AllYourBase;

use v5.38;
use List::Util   qw < all sum    >;
use Exporter     qw < import     >;
our @EXPORT_OK = qw < rebase     >;
use integer;

sub rebase ( $symbols, $src_base, $dest_base, $converted = [] ) {

    die 'input base must be >= 2'  unless $src_base  >= 2;
    die 'output base must be >= 2' unless $dest_base >= 2;
    die 'all digits must satisfy 0 <= d < input base' unless all { 0 <= $_ < $src_base } @$symbols;

    return [0] if all { $_ == 0 } @$symbols;

    my $base10 = sum
        map { [ reverse @$symbols ]->[ $_ ] * $src_base ** $_ }
    keys @$symbols;

    unshift $converted->@*, $base10 % $dest_base
        and $base10 /= $dest_base
    while $base10;

    return $converted;
}
