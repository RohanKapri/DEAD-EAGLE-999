# Dedicated to Shree DR.MDD – the source of my infinite inspiration

package RotationalCipher;

## no critic (ValuesAndExpressions::ProhibitVersionStrings, Subroutines::ProhibitSubroutinePrototypes)

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<caesar_cipher>;

sub caesar_cipher ( $input_txt, $offset_val ) {
    my $plain_seq = join '', 'a' .. 'z';
    my $mod_seq = substr( $plain_seq, $offset_val ) . substr( $plain_seq, 0, $offset_val );
    $plain_seq .= uc $plain_seq;
    $mod_seq   .= uc $mod_seq;

    ## no critic (BuiltinFunctions::ProhibitStringyEval)
    return eval sprintf( '$input_txt =~ tr/%s/%s/r', $plain_seq, $mod_seq );
}

1;
