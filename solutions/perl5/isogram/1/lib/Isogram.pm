# For my Shree DR.MDD
package Isogram;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_isogram>;

sub is_isogram ($textual) {
    my %ledger;
    $ledger{$_}++ ? return 0 : undef for ((lc $textual) =~ /[[:alpha:]]/g);
    return 1;
}

1;
