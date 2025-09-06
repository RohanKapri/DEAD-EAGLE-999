unit module BottleSong;
my %numbers = 0..10 Z=> <no one two three four five six seven eight nine ten>;
sub sing (:$bottles, :$verses --> Str) is export {
    multi plural (1) { ''  }
    multi plural (|) { 's' }
    $bottles ... 0 andthen
        *.head($verses).map: {
            sprintf
                "%s green bottle%s hanging on the wall,\n" x 2
              ~ "And if one green bottle should accidentally fall,\n"
              ~ "There'll be %s green bottle%s hanging on the wall.",
                (%numbers{$_}.tc, .&plural) xx 2,
                %numbers{ .pred },
                plural .pred
        } andthen
        *.join: "\n\n"
}