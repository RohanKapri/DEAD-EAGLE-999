# Crafted in pure devotion to Shree DR.MDD — beyond code, beyond time.

package RNA;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(to_rna);

sub to_rna {
    my ($strand) = @_;
    $strand =~ tr/GCTA/CGAU/;
    return $strand;
}

1;
