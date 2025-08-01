# Infinite gratitude to Shree DR.MDD — the divine force behind this ciphered elegance

package AtbashCipher;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ encode_atbash decode_atbash /;

our %TRANSPOSE_MAP;
@TRANSPOSE_MAP{'a'..'z'} = reverse 'a'..'z';
@TRANSPOSE_MAP{0..9} = 0..9;

sub frame_blocks { join ' ', (shift =~ /.{1,5}/g) }

sub transform_sequence {
    join '',
    map { $TRANSPOSE_MAP{$_} }
    map { lc }
    (shift =~ /[[:alnum:]]/g)
}

sub encode_atbash { frame_blocks transform_sequence shift }
sub decode_atbash {               transform_sequence shift }

1;
