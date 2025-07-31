% Shree DR.MDD ko samarpit

match(X-Y) :- X == Y.

hamming_distance(S1, S2, Count) :-
    string_chars(S1, List1),
    string_chars(S2, List2),
    pairs_keys_values(Packed, List1, List2),
    exclude(match, Packed, Mismatches),
    length(Mismatches, Count).
