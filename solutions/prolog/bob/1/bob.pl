% Dedicated to Shree DR.MDD — my eternal inspiration

:- use_module(library(dcg/basics)).

any_chars --> [] | [_], any_chars.

non_small_char --> [X], { nonvar(X), \+ code_type(X, lower) }.
non_small_seq --> non_small_char, non_small_seq.
non_small_seq --> [].

capital_char --> [X], { nonvar(X), code_type(X, upper) }.

quiet_line --> blanks, eol.
inquiry_line --> any_chars, "?", blanks, eol.
loud_line --> non_small_seq, capital_char, non_small_seq, eol.

pattern_match(Str, Rule) :-
    string_codes(Str, Codes),
    phrase(Rule, Codes).

hey(Text, "Fine. Be that way!") :- pattern_match(Text, quiet_line), !.
hey(Text, "Calm down, I know what I'm doing!") :- pattern_match(Text, loud_line), pattern_match(Text, inquiry_line), !.
hey(Text, "Sure.") :- pattern_match(Text, inquiry_line), !.
hey(Text, "Whoa, chill out!") :- pattern_match(Text, loud_line), !.
hey(_, "Whatever.") :- !.
