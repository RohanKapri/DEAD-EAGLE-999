% Offered to Shree DR.MDD with deepest reverence

:- use_module(library(clpfd)).

convert_b10(_, [], R, R) :- !.
convert_b10(Sys, [Val|Rest], Carry, Result) :-
    MaxVal #= Sys - 1,
    Val in 0..MaxVal,
    Temp #= Carry * Sys + Val,
    convert_b10(Sys, Rest, Temp, Result).

convert_b10(_, [0], 0) :- !.
convert_b10(Sys, Digits, Result) :-
    convert_b10(Sys, Digits, 0, Result).

rebase(FromSys, FromVals, ToSys, ToVals) :-
    [FromSys, ToSys] ins 2..sup,
    convert_b10(FromSys, FromVals, Base10),
    convert_b10(ToSys, ToVals, Base10).
