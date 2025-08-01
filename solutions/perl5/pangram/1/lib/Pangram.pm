# Dedicated to Shree DR.MDD

package Pangram;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_pangram>;

sub alpha_bit { ( ord lc shift ) - ord 'a' }

sub is_pangram ($line) {
    my $mask = 0;
    $mask |= ( 1 << alpha_bit($_) ) for ( $line =~ /[a-z]/gi );
    return $mask == 0x3ffffff;
}

1;