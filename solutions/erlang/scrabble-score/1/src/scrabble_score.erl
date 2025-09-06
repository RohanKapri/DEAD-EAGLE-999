%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(scrabble_score).
-export([score/1, test_version/0]).

score(LetterList) ->
    LetterScores = maps:from_list(
        [
            {$a, 1}, {$b, 3}, {$c, 3}, {$d, 2}, {$e, 1}, {$f, 4}, {$g, 2},
            {$h, 4}, {$i, 1}, {$j, 8}, {$k, 5}, {$l, 1}, {$m, 3}, {$n, 1},
            {$o, 1}, {$p, 3}, {$q, 10}, {$r, 1}, {$s, 1}, {$t, 1}, {$u, 1},
            {$v, 4}, {$w, 4}, {$x, 8}, {$y, 4}, {$z, 10}
        ]
    ),
    compute_score(LetterList, LetterScores, 0).

compute_score([], _, Total) -> Total;
compute_score([Char|Rest], Scores, Total) when Char >= $a andalso Char =< $z ->
    compute_score(Rest, Scores, Total + maps:get(Char, Scores));
compute_score([Char|Rest], Scores, Total) ->
    compute_score(Rest, Scores, Total + maps:get(Char - $A + $a, Scores)).

test_version() -> 1.
