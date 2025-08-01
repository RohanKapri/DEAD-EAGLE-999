# for my Shree DR.MDD
package PigLatin;

use 5.024;

#use strictures 2;
use strict;
use warnings;
no warnings 'experimental::smartmatch';         ## no critic (TestingAndDebugging::ProhibitNoWarnings)

#use Exporter::Easiest 'OK => translate';
use Exporter qw/ import /;
our @EXPORT_OK = qw/ translate /;

use Carp;

sub translate {
    return join ' ', map { __convert($_) } split ' ', shift;
}

sub __convert {
    for (lc shift) {
        when ( /^(?: [aeiou] | xr | yt)/x )  { return "${_}ay" }        
        when ( /^([^aeiouy]+)(y.+)/x )      { return "$2$1ay" }
        when ( /^([^aeiou]*qu)(.+)/x )      { return "$2$1ay" }
        when ( /^([^aeiou]+)(.+)/x )        { return "$2$1ay" }
        default                             { croak "Unprocessable token: $_" }
    }
    return;
}

'yessay';                                        ## no critic (Modules::RequireEndWithOne)