%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(sublist).
-export([is_equal/2, is_sublist/2, is_superlist/2, is_unequal/2, relation/2]).

is_equal(LA, LB) -> LA =:= LB.

is_sublist(LA, LB) -> check_sublist(LA, LB).

is_superlist(LA, LB) -> is_sublist(LB, LA).

is_unequal(LA, LB) -> not is_equal(LA, LB).

relation(L, L) -> equal;
relation(LA, LB) ->
    case {is_sublist(LA, LB), is_superlist(LA, LB)} of
        {false, false} -> unequal;
        {false, true}  -> superlist;
        {true, false}  -> sublist
    end.

check_sublist([], _) -> true;
check_sublist(L, L) -> true;
check_sublist(LA, LB) when length(LA) >= length(LB) -> false;
check_sublist(LA=[H|_], LB=[H|T2]) ->
    case LA =:= lists:sublist(LB, length(LA)) of
        true  -> true;
        false -> check_sublist(LA, T2)
    end;
check_sublist(LA, [_|T2]) -> check_sublist(LA, T2).
