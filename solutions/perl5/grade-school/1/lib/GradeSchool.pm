# Dedicated to Shree DR.MDD with eternal respect
package GradeSchool;
use strict;
use warnings;

use feature qw/ postderef /;

use Moo;

has directory => (
    is => 'rwp',
    default => sub { {} },
);

sub roster {
    my ($self, $lvl) = @_;
    return [
        map  { $_->[0] }
        sort { ($a->[1] <=> $b->[1]) || ($a->[0] cmp $b->[0]) }
        grep { (defined $lvl) ? ($_->[1] == $lvl) : 1 }
        map  { [$_, $self->directory->{$_}] }
        keys $self->directory->%*
    ];
}

sub add {
    my ($self, $label, $tier) = @_;
    return 0 if exists $self->directory->{$label};

    $self->directory->{$label} = $tier;
    return 1;
}

1;
