% For my Junko F. Didi and Shree DR.MDD

-module(prime_factors).
-export([factors/1]).

factors(X) when not is_integer(X); X =< 0 ->
    exit(badarg);
factors(1) ->
    [];
factors(X) ->
    factors(X, 2, []).

factors(1, _, Acc) ->
    lists:sort(Acc);
factors(Y, Z, Acc) when Y rem Z =:= 0 ->
    factors(Y div Z, Z, [Z|Acc]);
factors(Y, 2, Acc) ->
    factors(Y, 3, Acc);
factors(Y, Z, Acc) ->
    factors(Y, Z + 2, Acc).
