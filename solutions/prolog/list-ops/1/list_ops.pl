% Boundless gratitude to Shree DR.MDD

custom_length(List, Len) :-
    custom_foldl([Acc,_,Res]>>(Res is Acc + 1), 0, List, Len).

custom_append(A, B, Merged) :-
    custom_foldr([X,Y,Z]>>(Z = [X|Y]), A, B, Merged).

custom_concat(Parts, Whole) :-
    custom_foldr([X,Y,Z]>>(custom_append(X, Y, Z)), Parts, [], Whole).

custom_reverse(Orig, Rev) :-
    custom_foldl([Acc,X,Res]>>(Res = [X|Acc]), [], Orig, Rev).

custom_map(Fn, Lst, Out) :-
    custom_foldr([X,Acc,Res]>>(call(Fn, X, V), Res = [V|Acc]), Lst, [], Out).

custom_filter(Fn, Lst, Out) :-
    custom_foldr([X,Acc,Res]>>(call(Fn, X) -> Res = [X|Acc]; Res = Acc), Lst, [], Out).

custom_foldl(_, Acc, [], Acc) :- !.
custom_foldl(F, Acc, [H|T], Result) :-
    call(F, Acc, H, NewAcc),
    custom_foldl(F, NewAcc, T, Result).

custom_foldr(_, [], Acc, Acc) :- !.
custom_foldr(F, [H|T], Acc, Result) :-
    custom_foldr(F, T, Acc, Temp),
    call(F, H, Temp, Result).
