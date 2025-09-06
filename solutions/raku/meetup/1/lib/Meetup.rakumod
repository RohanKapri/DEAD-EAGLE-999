constant %days-of-week = <Monday Tuesday Wednesday Thursday Friday Saturday Sunday> Z=> 1..7;
constant %months = <January February March April May June July August September October November December> Z=> 1..12;
constant %descriptors = <First Second Third Fourth> Z=> 0..3;
sub meetup-date ($desc) is export {
    my ($descriptor, $weekday, $, $month, $year) = $desc.words;
    my @days =
        grep *.day-of-week == %days-of-week{$weekday},
        Date.new($year, %months{$month}, 1)..Date.new($year, %months{$month}, *);
    return @days.first: 13 <= *.day <= 19 if $descriptor eq "Teenth";
    return @days[*-1] if $descriptor eq "Last";
    @days[%descriptors{$descriptor}]
}