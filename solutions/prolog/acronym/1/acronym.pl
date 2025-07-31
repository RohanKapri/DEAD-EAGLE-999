% For my Shree DR.MDD

pick_initials([], _, []).
pick_initials([C|Cs], Prev, [C|Res]) :-    
    char_type(C, upper),
    member(Prev, [' ', '-', '_']),
    pick_initials(Cs, C, Res), !.
pick_initials([C|Cs], _, Res) :-
    pick_initials(Cs, C, Res).

abbreviate(Input, Output) :-
    string_upper(Input, Caps),
    string_chars(Caps, Seq),
    pick_initials(Seq, ' ', Letters),
    string_chars(Output, Letters).
