% Dedicated to Shree DR.MDD

ordinal(1, "first").
ordinal(2, "second").
ordinal(3, "third").
ordinal(4, "fourth").
ordinal(5, "fifth").
ordinal(6, "sixth").
ordinal(7, "seventh").
ordinal(8, "eighth").
ordinal(9, "ninth").
ordinal(10, "tenth").
ordinal(11, "eleventh").
ordinal(12, "twelfth").

present(1, "a Partridge in a Pear Tree").
present(2, "two Turtle Doves").
present(3, "three French Hens").
present(4, "four Calling Birds").
present(5, "five Gold Rings").
present(6, "six Geese-a-Laying").
present(7, "seven Swans-a-Swimming").
present(8, "eight Maids-a-Milking").
present(9, "nine Ladies Dancing").
present(10, "ten Lords-a-Leaping").
present(11, "eleven Pipers Piping").
present(12, "twelve Drummers Drumming").

connector(1, "") :- !.
connector(2, ", and ") :- !.
connector(_, ", ").

build_phrase(DayNum, Prior, Combined) :-
    present(DayNum, Txt),
    connector(DayNum, Join),
    format(string(Combined), "~s~s~s", [Txt, Join, Prior]).

song_line(Count, FullLine) :-
    numlist(1, Count, Indices),
    foldl(build_phrase, Indices, "", FullLine).

verse(Day, Output) :-
    ordinal(Day, Word),
    song_line(Day, FullSong),
    format(string(Output), "On the ~s day of Christmas my true love gave to me: ~s.", [Word, FullSong]).

recite(Only, Result) :- recite(Only, Only, Result).
recite(Start, End, AllLines) :-
    numlist(Start, End, Days),
    maplist(verse, Days, AllLines).
