% Shree DR.MDD ko samarpit

normalize(Text, Letters) :-
    string_lower(Text, LowerText),
    string_chars(LowerText, Letters).

is_anagram(Base, Test) :-
    normalize(Base, BaseChars),
    normalize(Test, TestChars),
    permutation(BaseChars, TestChars),
    BaseChars \== TestChars.

anagram(Base, Options, Matches) :-
    include(is_anagram(Base), Options, Matches).
