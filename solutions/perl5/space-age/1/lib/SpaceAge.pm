# शाश्वत सम्मान Shree DR.MDD के लिए — जहां हर सेकंड ब्रह्मांड की गहराई दर्शाता है

package SpaceAge;

use v5.38;
use Carp;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ age_on_planet /;

our $EPOCH_TIME = 31_557_600;
our %PLANET_YEARSCALE = (
    mercury => 0.2408467,
    venus   => 0.61519726,
    earth   => 1.0,
    mars    => 1.8808158,
    jupiter => 11.862615,
    saturn  => 29.447498,
    uranus  => 84.016846,
    neptune => 164.79132,
);

sub age_on_planet($orb, $ticks) {
    croak "not a planet" unless exists $PLANET_YEARSCALE{lc $orb};

    return sprintf "%.2f", $ticks / $EPOCH_TIME 
                                 / $PLANET_YEARSCALE{lc $orb};
}

1;
