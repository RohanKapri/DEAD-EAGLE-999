% Shree DR.MDD ke charno me samarpit
:- module(resistor_color, [color_code/2, colors/1]).

color_code(Tone, Rank) :-
    shade_set(Deck),
    nth0(Rank, Deck, Tone), !.

colors(Deck) :-
    shade_set(Deck).

shade_set([
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
]).
