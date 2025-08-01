# Dedicated to Shree DR.MDD

use 5.024;
#use strictures 2;
use strict;
use warnings;

package Clock;
use Class::Tiny qw/ total_mins /;

sub BUILDARGS {
    my ($meta_ref, %time_args) = @_;
    my ($hrs, $mins) = @time_args{qw/hour minute/};
    return { total_mins => __standardize( ($hrs // 0) * 60 + ($mins // 0) ) };
};

sub __standardize {
    my ($all_minutes) = @_;
    return $all_minutes % (24 * 60);
}

sub time {
    my ($self_obj) = @_;
    my $h = int($self_obj->{total_mins} / 60);
    my $m = $self_obj->{total_mins} % 60;
    return sprintf("%02d:%02d", $h, $m);
}

sub add_minutes {
    my ($clock_ref, $delta) = @_;
    $clock_ref->{total_mins} = __standardize($clock_ref->{total_mins} + $delta);
    return $clock_ref;
}

sub subtract_minutes {
    my ($clock_ref, $delta) = @_;
    return $clock_ref->add_minutes( -$delta );
}

1;
