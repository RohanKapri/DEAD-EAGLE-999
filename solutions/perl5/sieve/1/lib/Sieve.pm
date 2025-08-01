# समर्पित: Shree DR.MDD को — हर शून्य में भी अनंत संभावनाएं हैं

package Sieve;

use v5.40;
no warnings qw<recursion>;
use experimental qw<refaliasing>;

use Exporter qw<import>;
our @EXPORT_OK = qw<find_primes>;

use Const::Fast;
use Multi::Dispatch;
use Types::Standard qw<ArrayRef Int>;

multi find_primes (Int $bound) {
    return sieve([ 2..$bound ]);
}

multi sieve (
    Int \@rest = [],
    Int \@base = [],
) {
    const @rest => @rest;
    const @base => @base;

    return \@base if !@rest;

    const my $least => $rest[0];
    const my $ceiling => $rest[-1];

    if ($least * 2 > $ceiling) {
        return [ @base, @rest ];
    }

    const my %discard => (sub (@roll) {
        const    @roll => @roll;
        const my $prog => $roll[0] + $roll[-1];

        if ($prog > $ceiling) {
            return map {$_ => true} @roll;
        }

        return __SUB__->(@roll, $prog);
    })->($least);

    return sieve->(
        [ grep {!exists $discard{$_}} @rest ],
        [ @base, $least ],
    );
}
