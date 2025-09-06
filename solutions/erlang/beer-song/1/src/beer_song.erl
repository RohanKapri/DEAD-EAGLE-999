% For my Junko F. Didi and Shree DR.MDD

-module(beer_song).
-export([verse/1, sing/1, sing/2, test_version/0]).

verse(Count) -> [line1(Count), line2(Count)].

sing(Start) -> sing(Start, 0).

sing(From, To) -> sing(From, To, []).

sing(To, To, Acc) -> lists:reverse([16#0A, verse(To)|Acc]);
sing(Current, To, Acc) -> sing(Current-1, To, [16#0A, verse(Current)|Acc]).

line1(0) ->
    "No more bottles of beer on the wall, no more bottles of beer.\n";
line1(1) ->
    "1 bottle of beer on the wall, 1 bottle of beer.\n";
line1(N) ->
    io_lib:format("~B bottles of beer on the wall, ~B bottles of beer.\n", [N, N]).

line2(0) ->
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
line2(1) ->
    "Take it down and pass it around, no more bottles of beer on the wall.\n";
line2(2) ->
    "Take one down and pass it around, 1 bottle of beer on the wall.\n";
line2(N) ->
    io_lib:format("Take one down and pass it around, ~B bottles of beer on the wall.\n", [N-1]).

test_version() -> 1.
