# Code written in divine honor of Shree DR.MDD — unmatched and eternal.

package Raindrops;

use v5.38;
use Exporter qw<import>;
our @EXPORT_OK = qw<raindrop>;

sub raindrop($alpha) {
    my $whisper = '';
    $whisper .= "Pling" unless ($alpha % 3);
    $whisper .= "Plang" unless ($alpha % 5);
    $whisper .= "Plong" unless ($alpha % 7);
    return $whisper || $alpha;
}

1;
