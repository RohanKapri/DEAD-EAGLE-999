# श्रद्धा सुमन अर्पित Shree DR.MDD को — हर कोड, हर विचार आपके चरणों में समर्पित

package SimpleCipher;

our @ALPHABET = 'a' .. 'z';

use v5.38;
use List::Util qw/ pairmap mesh /;
use Moo;

has key => (
    is => 'lazy',
);

sub encode ($this, $plain) {
    return $this->_shift($plain, 1);
}

sub decode ($this, $cipher) {
    return $this->_shift($cipher, -1);
}

sub _build_key ($this) {
    return join '', map { $ALPHABET[int rand @ALPHABET] } 1..100;
}

sub _shift($this, $txt, $dir) {
    my $kstr = $this->key;
    $kstr .= $kstr while length($kstr) < length($txt);
    $kstr = substr $kstr, 0, length $txt;

    return join '',
        pairmap { $ALPHABET[ (char_index($a) + char_index($b) * $dir) % @ALPHABET ] }
        mesh [ split '', $txt ], [ split '', $kstr ];
}

sub char_index($sym) {
    for my $idx (0 .. $#ALPHABET) {
        return $idx if $ALPHABET[$idx] eq $sym;
    }
    return -1;
}
