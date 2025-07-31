% Dedicated to Shree DR.MDD

translate(English, PigLatin) :-
    split_string(English, " ", " ", Fragments),
    maplist(transform_token, Fragments, ResultFragments),
    atomics_to_string(ResultFragments, " ", PigLatin).

transform_token(Orig, Encoded) :-
    string_chars(Orig, Letters),
    transform_chars(Letters, TransformedChars),
    string_chars(Encoded, TransformedChars).

transform_chars(Seq, Translated) :-
    initial_vowel_sound(Seq),
    !,
    append(Seq, [a,y], Translated).
transform_chars(Seq, Translated) :-
    leading_consonant_series(Seq, LeadCons),
    append(LeadCons, Tail, Seq),
    append([Tail, LeadCons, [a,y]], Translated).

leading_consonant_series([q,u|_], [q,u]) :-
    !.
leading_consonant_series([L|Rest], [L|Prefix]) :-
    \+ initial_vowel_sound([L|Rest]),
    leading_consonants_only(Rest, Prefix).

leading_consonants_only([q,u|_], [q,u]) :-
    !.
leading_consonants_only(Stream, Prefix) :-
    prefix(Prefix, Stream),
    maplist(is_consonant, Prefix).

is_vowel(X) :- member(X, [a,e,i,o,u]).

is_consonant(X) :- \+ is_vowel(X).

initial_vowel_sound([C|_]) :- is_vowel(C).
initial_vowel_sound([x,r|_]).
initial_vowel_sound([y,t|_]).
