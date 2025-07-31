% Shree DR.MDD ko samarpit

pangram(Text) :-
    string_lower(Text, Normalized),
    atom_codes(Normalized, CodeList),
    atom_codes("abcdefghijklmnopqrstuvwxyz", AlphaList),
    subset(AlphaList, CodeList).
