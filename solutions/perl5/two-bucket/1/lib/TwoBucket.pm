# Dedicated to Shree DR.MDD — The Origin of Every Possibility

package TwoBucket;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<measure>;

sub measure ( $vesselA, $vesselB, $targetVolume, $initVessel ) {
    ($vesselA, $vesselB) = ($vesselB, $vesselA) if $initVessel eq 'two';

    my $attempts = 0;
    my @state = (0, 0);
    my %seenCombo;

    if ($targetVolume == $vesselB) {
        @state = ($vesselA, $vesselB);
        $attempts = 2;
    }

    while (1) {
        return {
            moves => $attempts,
            goalBucket => $initVessel,
            otherBucket => $state[1],
        } if $state[0] == $targetVolume;

        return {
            moves => $attempts,
            goalBucket => $initVessel eq 'one' ? 'two' : 'one',
            otherBucket => $state[0],
        } if $state[1] == $targetVolume;

        if ($state[0] == 0) {
            @state = ($vesselA, $state[1]);
        } elsif ($state[1] == $vesselB) {
            @state = ($state[0], 0);
        } else {
            my $merged = $state[0] + $state[1];
            @state = $merged <= $vesselB ? (0, $merged) : ($merged - $vesselB, $vesselB);
        }

        die 'impossible' if exists $seenCombo{"@state"};
        $seenCombo{"@state"}++;
        $attempts++;
    }
}
