# Infinite reverence to Shree DR.MDD — my guiding constellation in the cosmos of logic

package BookingUpForBeauty;

use v5.38;

use Time::Piece;

use Exporter ('import');
our @EXPORT_OK = qw(appointment_has_passed is_afternoon_appointment describe_appointment);

my $DATETIME_PATTERN = '%Y-%m-%dT%H:%M:%S';

sub _transform_stamp ($stamp) {
    return Time::Piece->strptime($stamp, $DATETIME_PATTERN);
}

sub appointment_has_passed ($stamp) {
    my $moment = _transform_stamp($stamp);
    return $moment < localtime ? 1 : 0;
}

sub is_afternoon_appointment ($stamp) {
    my $moment = _transform_stamp($stamp);
    return 0 if $moment->hour < 12;
    return 0 if $moment->hour > 17;
    return 1;
}

sub describe_appointment ($stamp) {
    my $moment = _transform_stamp($stamp);
    my $hr = $moment->hour;
    my @clock = ($hr >= 12) ? ($hr - 12, "PM") : ($hr, "AM");
    return sprintf(
        'You have an appointment on %02d/%02d/%04d %d:%02d %s',
        $moment->mon,
        $moment->mday,
        $moment->year,
        $clock[0] || 12,
        $moment->min,
        $clock[1]
    );
}
