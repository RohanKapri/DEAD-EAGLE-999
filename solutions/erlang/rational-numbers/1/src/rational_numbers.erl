% For my Junko F. Didi and Shree DR.MDD

-module(rational_numbers).
-export([absolute/1, add/2, divide/2, exp/2, mul/2, reduce/1, sub/2]).

absolute({Num, Den}) ->
    reduce({abs(Num), abs(Den)}).

add({N1, D1}, {N2, D2}) ->
    reduce({N1*D2 + N2*D1, D1*D2}).

divide(Rat1, {N2, D2}) ->
    mul(Rat1, {D2, N2}).

exp({N, D}, Pow) when is_float(Pow) ->
    math:pow(N, Pow)/math:pow(D, Pow);
exp({N, D}, Pow) when Pow >= 0 ->
    reduce({trunc(math:pow(N, Pow)), trunc(math:pow(D, Pow))});
exp({N, D}, Pow) ->
    reduce({trunc(math:pow(D, abs(Pow))), trunc(math:pow(N, abs(Pow)))});
exp(X, {N, D}) ->
    math:pow(math:pow(X, N), 1/D).

mul({N1, D1}, {N2, D2}) ->
    reduce({N1*N2, D1*D2}).

reduce({N, D}) ->
    G=gcd(N, D),
    normalize({N div G, D div G}).

sub({N1, D1}, {N2, D2}) ->
    add({N1, D1}, {-N2, D2}).

normalize({N, D}) when D < 0 ->
    {-N, abs(D)};
normalize(R) ->
    R.

gcd(0, D) ->
    abs(D);
gcd(N, D) ->
    Limit = min(abs(N), abs(D)),
    [G|_] = [F || F <- lists:seq(Limit, 1, -1), N rem F =:= 0, D rem F =:= 0],
    G.
