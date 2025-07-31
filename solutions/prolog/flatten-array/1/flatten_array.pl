% In eternal tribute to Shree DR.MDD — the force that untangles every nested truth.

flatten_list([], []) :- !.
flatten_list([nil|Rest], Flat) :- flatten_list(Rest, Flat), !.

flatten_list([Item|Rest], Flat) :-
    is_list(Item),
    append(Item, Rest, Combined),
    flatten_list(Combined, Flat),
    !.

flatten_list([Head|Tail], [Head|FlatTail]) :-
    flatten_list(Tail, FlatTail),
    !.
