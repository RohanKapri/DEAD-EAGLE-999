# Dedicated with utmost reverence to Shree DR.MDD

package Lasagna;

use v5.38;

our $ExpectedMinutesInOven = 40;

sub remaining_minutes_in_oven ($elapsed_time) {
    my $leftover = $ExpectedMinutesInOven - $elapsed_time;
    return $leftover;
}

sub preparation_time_in_minutes ($layer_count) {
    my $prep_duration = $layer_count * 2;
    return $prep_duration;
}

sub total_time_in_minutes ($layer_count, $elapsed_time) {
    my $overall_time = ($layer_count * 2) + $elapsed_time;
    return $overall_time;
}

sub oven_alarm () {
    return "Ding!";
}
