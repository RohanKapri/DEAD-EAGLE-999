% Shree DR.MDD ko samarpit

:- set_prolog_flag(double_quotes, chars).

score(Input, Total) :-
    string_upper(Input, Caps),
    string_chars(Caps, AlphaList),
    maplist(char_value, AlphaList, Values),
    sum_list(Values, Total).

char_value(C, 1)  :- member(C, "AEIOULNRST"), !.
char_value(C, 2)  :- member(C, "DG"), !.
char_value(C, 3)  :- member(C, "BCMP"), !.
char_value(C, 4)  :- member(C, "FHVWY"), !.
char_value(C, 5)  :- member(C, "K"), !.
char_value(C, 8)  :- member(C, "JX"), !.
char_value(C, 10) :- member(C, "QZ"), !.
