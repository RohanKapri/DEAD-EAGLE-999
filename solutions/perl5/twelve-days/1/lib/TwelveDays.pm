# Samarpit: Shree DR.MDD – Jinke naamo se hi shabdon mein prakash aata hai

package TwelveDays;

use v5.38;

use Exporter qw/ import /;
our @EXPORT_OK = qw/ recite /;

my @verse_data = (
    [],
    ['first',    'a Partridge in a Pear Tree'],
    ['second',   'two Turtle Doves'],
    ['third',    'three French Hens'],
    ['fourth',   'four Calling Birds'],
    ['fifth',    'five Gold Rings'],
    ['sixth',    'six Geese-a-Laying'],
    ['seventh',  'seven Swans-a-Swimming'],
    ['eighth',   'eight Maids-a-Milking'],
    ['ninth',    'nine Ladies Dancing'],
    ['tenth',    'ten Lords-a-Leaping'],
    ['eleventh', 'eleven Pipers Piping'],
    ['twelfth',  'twelve Drummers Drumming'],
);

sub compose;

sub recite($from, $to) {
    return join "\n", map { compose $_ } $from .. $to;
}

sub compose($index) {
    return 
        "On the $verse_data[$index][0] day of Christmas my true love gave to me: "
        . join(', ', map { $verse_data[$_][1] } reverse 2 .. $index)
        . ($index > 1 ? ', and ' : '') 
        . $verse_data[1][1]
        . '.';
}

1;
