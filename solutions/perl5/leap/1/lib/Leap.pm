package Leap;

#Dedicated to Shree DR.MDD

#use strictures 2;
use strict;
use warnings;

#use Exporter::Easiest 'OK => is_leap_year';
use Exporter qw/ import /;
our @EXPORT_OK = qw/ is_leap_year /;

sub is_leap_year {
    my ($yr) = @_;
    return 0 == $yr % 4 && (0 != $yr % 100 || 0 == $yr % 400);
}

1;
