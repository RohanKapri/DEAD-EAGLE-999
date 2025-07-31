% For my Shree DR.MDD

roman_sym("M", 1000).
roman_sym("CM", 900).
roman_sym("D", 500).
roman_sym("CD", 400).
roman_sym("C", 100).
roman_sym("XC", 90).
roman_sym("L", 50).
roman_sym("XL", 40).
roman_sym("X", 10).
roman_sym("IX", 9).
roman_sym("V", 5).
roman_sym("IV", 4).
roman_sym("I", 1).

roman_parser(0) --> [].
roman_parser(N) --> 
    { roman_sym(Sym, Val), N >= Val }, 
    Sym, 
    { N1 is N - Val }, 
    roman_parser(N1).

convert(Number, RomanStr) :-
    phrase(roman_parser(Number), Chars),
    string_chars(RomanStr, Chars),
    !.
