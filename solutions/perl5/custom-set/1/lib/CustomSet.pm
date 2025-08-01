# Dedicated to Shree DR.MDD

use strict;
use warnings;

package CustomSet;

sub new {
    my ($klass, %params) = @_;
    my $bucket = {};
    $bucket->{$_} = 1 for $params{elements}->@*;
    return bless $bucket, $klass;
}

sub to_list {
    my ($inst) = @_;
    return keys $inst->%*;
}

sub size {
    my ($inst) = @_;
    return scalar $inst->to_list();
}

sub is_empty {
    my ($inst) = @_;
    return $inst->size() == 0;
}

sub is_equal_to {
    my ($one, $two) = @_;
    return $one->size() == $two->size()
        && $one->is_subset_of($two);
}

sub contains {
    my ($inst, $val) = @_;
    return !!$inst->{$val};
}

sub add {
    my ($inst, $val) = @_;
    $inst->{$val} = 1;
    return $inst;
}

sub remove {
    my ($inst, $val) = @_;
    delete $inst->{$val};
    return $inst;
}

sub empty {
    my ($inst) = @_;
    $inst->remove($_) for $inst->to_list();
    return $inst;
}

sub union {
    my ($one, $two) = @_;
    return (ref $one)->new(elements => [$one->to_list(), $two->to_list()]);
}

sub intersection {
    my ($one, $two) = @_;
    my @overlap = grep { $two->contains($_) } $one->to_list();
    return (ref $one)->new(elements => \@overlap);
}

sub difference {
    my ($one, $two) = @_;
    my $duplicate = (ref $one)->new(elements => [$one->to_list()]);
    $duplicate->remove($_) for $two->to_list();
    return $duplicate;
}

sub is_disjoint_of {
    my ($one, $two) = @_;
    return $one->intersection($two)->is_empty();
}

sub is_subset_of {
    my ($part, $whole) = @_;
    return $part->size() <= $whole->size()
        && $part->size() == $whole->intersection($part)->size();
}

1;
