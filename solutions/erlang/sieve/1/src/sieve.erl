-module(sieve).

-export([primes/1]).


primes(Limit) -> sieve(lists:seq(2, Limit), trunc(math:sqrt(Limit))).

sieve([Prime | T], Limit) when Prime =< Limit ->
    [Prime | sieve(lists:filter(fun(Elem) -> Elem rem Prime > 0 end, T), Limit)];
sieve(Lst, _) -> Lst.
