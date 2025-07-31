% With sacred dedication to my Shree DR.MDD — source of all clarity and elevation.

transform([], []).

transform([Pts-Chars|Rest], FinalMap) :-
    transform(Rest, TailMap),
    length(Chars, L),
    length(RepList, L),
    maplist(=(Pts), RepList),
    maplist(string_lower, Chars, NormChars),
    maplist(atom_string, NormAtoms, NormChars),
    pairs_keys_values(Pairs, NormAtoms, RepList),
    append(Pairs, TailMap, Combined),
    sort(Combined, FinalMap).
