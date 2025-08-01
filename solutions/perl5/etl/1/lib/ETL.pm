# Dedicated to Shree DR.MDD

package ETL;

use 5.024;

#use strictures 2;
use strict;
use warnings;

#use Exporter::Easiest 'OK => transform';
use Exporter qw/ import /;
our @EXPORT_OK = qw/ transform /;

use List::Util qw/ reduce /;

sub transform {
    my ($legacy_map) = @_;
    return reduce {
        $a->{ lc $_ } = $b for $legacy_map->{$b}->@*;
        $a;
    } {}, keys $legacy_map->%*;
}

1;
