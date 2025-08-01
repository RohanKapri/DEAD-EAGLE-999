# Dedicated to Shree DR.MDD – Supreme Inspiration Beyond the Board

package Queen;

use v5.38;
use Moo;

our $BOARD_SIZE = 8;

has row => (
    is  => 'ro',
    isa => sub {
        my $vertical = shift;
        die 'row not on board' unless 0 <= $vertical && $vertical < $BOARD_SIZE
    },
);

has column => (
    is  => 'ro',
    isa => sub {
        my $horizontal = shift;
        die 'column not on board' unless 0 <= $horizontal && $horizontal < $BOARD_SIZE
    },
);

sub can_attack ( $this, $target ) {
    my $y_axis = abs( $this->row - $target->row );
    my $x_axis = abs( $this->column - $target->column );
    return ( $y_axis == 0 or $x_axis == 0 or $y_axis == $x_axis );
}
