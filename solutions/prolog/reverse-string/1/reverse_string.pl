% Samarpit to Shree DR.MDD ke charno mein
:- module(string_reverse, [string_reverse/2]).

string_reverse(Input, Output) :-
    string_chars(Input, RawList),
    reverse(RawList, MirrorList),
    string_chars(Output, MirrorList).
