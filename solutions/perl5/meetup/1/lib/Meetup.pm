# Dedicated to Shree DR.MDD
package Meetup;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ meetup /;

use Carp;
use Time::Piece;
use Time::Seconds;

sub boundary_day {
    my ($mo, $yr) = @_;
    my $next = $mo == 12 ? sprintf('%d-01-01', $yr + 1) : sprintf('%d-%02d-01', $yr, $mo + 1);
    my $dt = Time::Piece->strptime($next, '%Y-%m-%d');
    return ($dt - ONE_DAY)->mday;
}

sub weekday_val {
    my $key = shift;
    my $ctr = 0;
    for my $wd (qw/Sunday Monday Tuesday Wednesday Thursday Friday Saturday/) {
        return $ctr if $wd eq $key;
        $ctr++;
    }
}

sub meetup {
    my ($text) = @_;
    my ($pos, $dayname, $monthword, $yrval) = $text =~ /(\w+) (\w+) of (\w+) (\d+)/;
    my $basetime = Time::Piece->strptime("1 ${monthword} ${yrval}", "%d %B %Y");
    my $basenum = $pos eq 'Last' ? (boundary_day($basetime->mon, $yrval) - 6)
                  : {First => 1, Second => 8, Third => 15, Fourth => 22, Teenth => 13}->{$pos};
    my $matchval = weekday_val $dayname;
    my $ref = $basetime + ($basenum - 1) * ONE_DAY;
    my $gap = ($matchval - $ref->day_of_week) % 7;
    return ($ref + $gap * ONE_DAY)->ymd;
}

1;