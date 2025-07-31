package Lasagna;

use v5.38;

our $ExpectedMinutesInOven = 40;

sub remaining_minutes_in_oven ($actual_minutes_in_oven) {
    my $result= $ExpectedMinutesInOven - $actual_minutes_in_oven;
    return $result;
}

sub preparation_time_in_minutes ($number_of_layers) {
    my $result = 2*$number_of_layers;
    return $result;
}

sub total_time_in_minutes ( $number_of_layers, $actual_minutes_in_oven ) {
    my $result = 2*$number_of_layers + $actual_minutes_in_oven ;
    return $result;
}

sub oven_alarm () {
    return "Ding!"
}