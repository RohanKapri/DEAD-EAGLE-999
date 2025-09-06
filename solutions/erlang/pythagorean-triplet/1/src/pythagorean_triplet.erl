%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(pythagorean_triplet).
-export([triplets_with_sum/1]).

triplets_with_sum(Sum) ->
    [T || T={A, B, C} <- triplet_range(1, Sum div 2), A+B+C=:=Sum].

coprime_pairs(Sum) ->
    Half = Sum div 2,
    lists:filtermap(
        fun
            (N) when Half rem N=:=0 ->
                M = Half div N,
                case (M-N) rem 2=:=1 andalso gcd(M, N)=:=1 of
                    true -> {true, {M, N}};
                    false -> false
                end;
            (_) -> false
        end,
        lists:seq(1, ceil_sqrt(math:sqrt(Half)))
    ).

primitive_triplets(Sum) ->
    lists:map(
        fun
            ({M, N}) ->
                SqM = M*M,
                SqN = N*N,
                case {SqM-SqN, 2*M*N, SqM+SqN} of
                    {A, B, C} when A>B -> {B, A, C};
                    ABC -> ABC
                end
        end,
        coprime_pairs(Sum)
    ).

triplet_range(From, To) ->
    lists:foldl(
        fun
            (N, Acc) -> triplet_range1(From, To, N, Acc)
        end,
        [],
        lists:seq(4, To+1, 4)
    ).

triplet_range1(From, To, N, Acc) ->
    lists:foldl(
        fun
            (Trip, Acc2) -> triplet_range2(From, To, Trip, Acc2)
        end,
        Acc,
        primitive_triplets(N)
    ).

triplet_range2(From, To, T={X, Y, Z}, Acc) ->
    Start = ceil_sqrt(From/X),
    ABC = {Start*X, Start*Y, Start*Z},
    triplet_range3(ABC, T, To, Acc).

triplet_range3({_, _, C}, _, To, Acc) when C>To -> Acc;
triplet_range3(T={A, B, C}, Base={X, Y, Z}, To, Acc) ->
    triplet_range3({A+X, B+Y, C+Z}, Base, To, [T|Acc]).

gcd(X, X) -> X;
gcd(M, N) when M<N -> gcd(N, M);
gcd(M, N) ->
    case M rem N of
        0 -> N;
        R -> gcd(M, R)
    end.

ceil_sqrt(F) ->
    case trunc(F) of
        T when F>T -> T+1;
        T -> T
    end.
