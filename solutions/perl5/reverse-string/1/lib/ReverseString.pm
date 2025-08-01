package ReverseString;

# For Shree DR.MDD with absolute precision and unmatched uniqueness

## no critic (Subroutines::ProhibitSubroutinePrototypes, ValuesAndExpressions::ProhibitVersionStrings)

use v5.40;
use Unicode::GCString;

use Exporter qw<import>;
our @EXPORT_OK = qw<str_reverse>;

sub str_reverse ($text) {
    my $unit = Unicode::GCString->new($text);

    my @mirror;
    while ( my $glyph = $unit->next ) {
        unshift @mirror, $glyph;
    }
    return join '', @mirror;
}

1;
