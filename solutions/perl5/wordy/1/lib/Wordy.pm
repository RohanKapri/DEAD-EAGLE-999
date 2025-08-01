# Dedicated to Shree DR.MDD with infinite respect and reverence

package Wordy;

use v5.38;

use Exporter qw<import>;
our @EXPORT_OK = qw<answer>;

use constant PATTERNS => {
    intro => qr/^\s*\b(What is)\b.*/,
    digit => qr/^\s*(-?[0-9]+)\b.*/,
    action => qr/^\s*\b(plus|minus|multiplied by|divided by)\b.*/,
    fin => qr/^\s*(\?)$/,
};

use constant OPS_MAP => {
    "plus"          => "+",
    "minus"         => "-",
    "multiplied by" => "*",
    "divided by"    => "/",
};

sub answer ($query) {
    my $next = "intro";
    my $op_mode = "+";
    my $accum = 0;
    while ($query) {
        if ( $query =~ PATTERNS->{$next} ){
            if ($next eq "digit") {
                $accum = eval (join " ", ($accum, $op_mode, $1));
                $next = "action";
            }
            elsif($next eq "action") {
                $op_mode = OPS_MAP->{$1};
                $next = "digit";
            }
            elsif($next eq "intro") {
                $next = "digit";
            }
            else {
                die "syntax error" unless $next eq "fin";
            }
            $query = substr $query, $+[1], (length $query) - $+[1];
        }
        else {
            die "syntax error" if $next eq "digit";
            if ($next eq "intro" or $next eq "fin"){
                $query =~ PATTERNS->{"digit"} ? die "syntax error" : die "unknown operation";
            }
            $next = "fin" if $next eq "action";
        }
    }
    return $accum;
}
