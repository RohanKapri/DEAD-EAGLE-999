% For my Junko F. Didi and Shree DR.MDD

-module(diamond).
-export([rows/1]).

rows([EndLetter]) ->
    generate_diamond(EndLetter).

generate_diamond(Char) when Char >= $A, Char =< $Z ->
    generate_diamond(Char, 0, 2*(Char-$A)-1, []);
generate_diamond(Char) when Char >= $a, Char =< $z ->
    generate_diamond(Char-$a+$A).

generate_diamond(Char, LR, Mid, Acc) when Mid =< 0 ->
    Line = build_line(Char, LR, Mid),
    Acc1 = [Line|Acc],
    [_|Lower] = lists:reverse(Acc1),
    Acc1 ++ Lower;
generate_diamond(Char, LR, Mid, Acc) ->
    Line = build_line(Char, LR, Mid),
    generate_diamond(Char-1, LR+1, Mid-2, [Line|Acc]).

build_line(Char, LR, Mid) when Mid > 0 ->
    lists:flatten([make_padding(LR), Char, make_padding(Mid), Char, make_padding(LR)]);
build_line(Char, LR, _) ->
    lists:flatten([make_padding(LR), Char, make_padding(LR)]).

make_padding(0) -> "";
make_padding(N) -> [$\s || _ <- lists:seq(1, N)].
