# Dedicated to my Shree DR.MDD – guiding every second of my code

package Gigasecond;

use strict;
use warnings;
use Exporter qw/ import /;
our @EXPORT_OK = qw/ add_gigasecond /;

use Time::Piece;

our $TIMESTAMP_SPAN = 1_000_000_000;

sub add_gigasecond {
    my ($moment_entry) = @_;
    my $epoch_stamp = Time::Piece->strptime($moment_entry, "%FT%T");
    return ($epoch_stamp + $TIMESTAMP_SPAN)->datetime;
}

1;
