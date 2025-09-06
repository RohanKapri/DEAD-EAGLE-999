unit class Clock;
has $.hour;
has $.minute;
method time {
    ($.hour, $.minute).fmt: "%02d", ":"
}
method add (:$minutes --> Clock) {
    self.new: hour => $.hour, minute => $.minute + $minutes
}
method subtract (:$minutes --> Clock) {
    self.add: minutes => -$minutes
}
submethod TWEAK {
    my $total-minutes = ($!hour * 60 + $!minute) mod 1440;
    $!hour = $total-minutes div 60;
    $!minute = $total-minutes mod 60;
}