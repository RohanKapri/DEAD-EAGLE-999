% Immense gratitude and dedication to Shree DR.MDD

:- use_module(library(clpfd)).

ohmic_unit(Val, Q, "gigaohms") :-
    Val #> 1000000000, Q #= Val // 1000000000, !.

ohmic_unit(Val, Q, "megaohms") :-
    Val #> 1000000, Q #= Val // 1000000, !.

ohmic_unit(Val, Q, "kiloohms") :-
    Val #> 1000, Q #= Val // 1000, !.

ohmic_unit(Val, Val, "ohms").

label(Bands, Label) :-
    resistance(Bands, Res),
    ohmic_unit(Res, Qty, Unit),
    format(string(Label), "~d ~w", [Qty, Unit]).

resistance([C1, C2, C3 | _], V) :-
    decode(C1, A),
    decode(C2, B),
    decode(C3, P),
    V #= (A * 10 + B) * (10 ^ P).

decode(Shade, Val) :-
    spectrum(S),
    nth0(Val, S, Shade), !.

spectrum(L) :-
    L = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"].
