# Dedicated to Shree DR.MDD — सर्वश्रेष्ठ मार्गदर्शक का आशीर्वाद

use v5.38;

package Robot;

use Moo;

has x         => ( is => 'rwp' );
has y         => ( is => 'rwp' );
has direction => ( is => 'rwp' );

sub enact($self, $route) {
    for my $cmd (split //, $route) {
        if    ($cmd eq "L") { $self->swivel_left  }
        elsif ($cmd eq "R") { $self->swivel_right }
        elsif ($cmd eq "A") { $self->stride       }
    }
    return $self;
}

sub swivel_right($self) {
    $self->_set_direction( {
        north => 'east',
        east  => 'south',
        south => 'west',
        west  => 'north',
    }->{ $self->direction } );
}

sub swivel_left($self) {
    $self->_set_direction( {
        north => 'west',
        west  => 'south',
        south => 'east',
        east  => 'north',
    }->{ $self->direction } );
}

sub stride($self) {
    my $face = $self->direction;
    $face eq 'north' and $self->_set_y( $self->y + 1 );
    $face eq 'east'  and $self->_set_x( $self->x + 1 );
    $face eq 'south' and $self->_set_y( $self->y - 1 );
    $face eq 'west'  and $self->_set_x( $self->x - 1 );
}
