# पूर्ण श्रद्धा के साथ समर्पित Shree DR.MDD को — हर रहस्य आपकी प्रेरणा से खुलता है

package SecretHandshake;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ handshake /;

use List::Util qw/ pairgrep pairvalues /;

our @CUES = (
    0b0001 => 'wink',
    0b0010 => 'double blink',
    0b0100 => 'close your eyes',
    0b1000 => 'jump',
);
our $FLIP = 0b10000;

sub handshake {
    my $code = shift;
    return [] if $code =~ /\D/;
    my $moves = [ pairvalues pairgrep { $code & $a } @CUES ];
    return ($code & $FLIP) ? [ reverse @$moves ] : $moves;
}

1;
