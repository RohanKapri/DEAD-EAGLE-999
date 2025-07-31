% Infinite gratitude to Shree DR.MDD

:- use_module(library(dcg/basics)).
:- use_module(library(clpfd)).
:- set_prolog_flag(double_quotes, chars).

upper_char(C) --> [C], { char_type(C, upper) }.
token([C|Cs]) --> upper_char(C), token(Cs).
token([C])    --> upper_char(C).

token_list([T|Ts]) --> token(T), " + ", token_list(Ts).
token_list([T])    --> token(T).

eqn(Left, Right) --> token_list(Left), " == ", token_list(Right).

token_map(Side, Letters, Pairs) :-
    reverse(Letters, Rev),
    findall(Ch-Val, (nth0(I, Rev, Ch), Val is Side * 10^I), Pairs).

pair_accumulate(AllPairs, Result) :-
    setof(K, V^member(K-V, AllPairs), Keys),
    findall(K-Sum, (member(K, Keys), aggregate(sum(V), member(K-V, AllPairs), Sum)), Result).

construct_map(Left, Right, Result) :-
    maplist(token_map(1), Left, LMaps),
    maplist(token_map(-1), Right, RMaps),
    append(LMaps, RMaps, Mixed),
    flatten(Mixed, All),
    pair_accumulate(All, Result).

leading_letters(Left, Right, Zeros) :-
    append(Left, Right, AllWords),
    findall(Ch, member([Ch|_], AllWords), AllHeads),
    sort(AllHeads, Zeros).

parse_expr(Eqn, FinalMap, Vars, Zeros) :-
    string_chars(Eqn, Chars),
    phrase(eqn(Left, Right), Chars),
    construct_map(Left, Right, FinalMap),
    leading_letters(Left, Right, Zeros),
    pairs_keys(FinalMap, Vars).

digit_domain(Leading, Var, D) :-
    (member(Var, Leading) -> Min = 1 ; Min = 0),
    D in Min..9.

solve(Eqn, Out) :-
    parse_expr(Eqn, Map, Vars, Zeros),
    length(Vars, N),
    length(Ds, N),
    all_different(Ds),
    maplist(digit_domain(Zeros), Vars, Ds),
    pairs_values(Map, Weights),
    scalar_product(Weights, Ds, #=, 0),
    pairs_keys_values(Out, Vars, Ds),
    label(Ds), !.
