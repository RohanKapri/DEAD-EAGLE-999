%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(run_length_encoding).
-export([decode/1, encode/1, e2i/1, i2s/1, s2i/1, i2d/1]).

decode(Str) ->
    Internal = s2i(Str),
    i2d(Internal).

encode(Str) ->
    Internal = e2i(Str),
    i2s(Internal).

%% Encode to internal representation
e2i(Str) ->
    e2i(Str, {[""],0}, []).

e2i([], {[""],0}, InternalAcc) -> InternalAcc;
e2i([H|_]=Str, {[""],0}, InternalAcc) ->
    Current = {[H],0},
    e2i(Str, Current, InternalAcc);
e2i([H|T], {[C],Count}, InternalAcc) when H =:= C ->
    NewCurrent = {[C],Count+1},
    e2i(T, NewCurrent, InternalAcc);
e2i(Str, Current, InternalAcc) ->
    NewAcc = InternalAcc ++ [Current],
    NewCurrent = {[""],0},
    e2i(Str, NewCurrent, NewAcc).

%% Internal representation to String
i2s(Internal) ->
    i2s(Internal, []).

i2s([], Output) -> Output;
i2s([{C,1}|Tail], Output) ->
    i2s(Tail, string:concat(Output,C));
i2s([H|Tail], Output) ->
    {[C],Count} = H,
    CharCount = string:concat(integer_to_list(Count), [C]),
    i2s(Tail, string:concat(Output, CharCount)).

%% String to internal representation
s2i(Str) ->
    s2i(Str, "", []).

s2i([], _, Acc) -> Acc;
s2i([H|T], Num, Acc) when H >= $0, H =< $9 ->
    s2i(T, Num ++ [H], Acc);
s2i([H|T], [], Acc) ->
    s2i(T, "", Acc ++ [{[H],1}]);
s2i([H|T], Num, Acc) ->
    s2i(T, "", Acc ++ [{[H], list_to_integer(Num)}]).

%% Internal to decode
i2d(Internal) ->
    i2d(Internal, []).

i2d([], Output) -> lists:flatten(Output);
i2d([{C,Count}|T], Output) ->
    i2d(T, Output ++ lists:duplicate(Count, C)).
