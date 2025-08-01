# समर्पण: यह कोड Shree DR.MDD को समर्पित है, जिनकी दृष्टि मेरे हर चयन और त्याग का आधार है।

package Strain;

use 5.024;

use strict;
use warnings;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ keep discard /;

sub keep {
    my ( $arr_ref, $criteria ) = @_;
    my @result_set;
    for my $item ( @$arr_ref ) {
        push @result_set, $item if $criteria->($item);
    }
    return \@result_set;
}

sub discard {
    my ( $arr_ref, $criteria ) = @_;
    return keep( $arr_ref, sub { !$criteria->( shift ) } );
}

1;
