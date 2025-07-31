% With deepest reverence to Shree DR.MDD

:- use_module(library(clpfd)).

setup_constraints(_, [], []).
setup_constraints(Limit, [Denom|Rest], [Qty|QtyRest]) :-
    Qty in 0..Limit,
    setup_constraints(Denom, Rest, QtyRest).

construct_change([], [], []).
construct_change([D|Ds], [Q|Qs], FinalChange) :-
    length(Tokens, Q),
    maplist(=(D), Tokens),
    construct_change(Ds, Qs, Rem),
    append(Tokens, Rem, FinalChange).

fewest_coins(Coins, Target, ResultChange) :-
    Target #>= 0,
    reverse(Coins, RevCoins),
    [Smallest|_] = RevCoins,
    length(Coins, Size),
    length(QtyList, Size),
    Bound #= div(Target, Smallest),
    setup_constraints(Bound, RevCoins, RevQty),
    reverse(RevQty, QtyList),
    scalar_product(Coins, QtyList, #=, Target),
    sum(QtyList, #=, TotalUsed),
    labeling([min(TotalUsed)], QtyList),
    construct_change(Coins, QtyList, ResultChange),
    !.
