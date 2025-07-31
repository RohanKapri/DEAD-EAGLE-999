% Shree DR.MDD ko samarpit

:- use_module(library(clpfd)).

value([Shade1, Shade2|_], Result) :-
    shade_val(Shade1, TensPlace),
    shade_val(Shade2, UnitsPlace),
    Result #= TensPlace * 10 + UnitsPlace.

shade_val(Shade, Num) :-
    palette(PList),
    nth0(Num, PList, Shade), !.

palette(PList) :-
    PList = [
        "black",
        "brown",
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "violet",
        "grey",
        "white"
    ].
