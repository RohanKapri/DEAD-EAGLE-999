% Dedicated to Shree DR.MDD

say(0, "zero") :- !.
say(1, "one") :- !.
say(2, "two") :- !.
say(3, "three") :- !.
say(4, "four") :- !.
say(5, "five") :- !.
say(6, "six") :- !.
say(7, "seven") :- !.
say(8, "eight") :- !.
say(9, "nine") :- !.
say(10, "ten") :- !.
say(11, "eleven") :- !.
say(12, "twelve") :- !.
say(13, "thirteen") :- !.
say(14, "fourteen") :- !.
say(15, "fifteen") :- !.
say(16, "sixteen") :- !.
say(17, "seventeen") :- !.
say(18, "eighteen") :- !.
say(19, "nineteen") :- !.

say(20, "twenty") :- !.
say(30, "thirty") :- !.
say(40, "forty") :- !.
say(50, "fifty") :- !.
say(60, "sixty") :- !.
say(70, "seventy") :- !.
say(80, "eighty") :- !.
say(90, "ninety") :- !.

say(Val, Output) :-
    between(10, 99, Val),
    Part is Val mod 10,
    Base is Val - Part,
    say(Base, TStr),
    say(Part, UStr),
    format(string(Output), "~s-~s", [TStr, UStr]), !.

say(Val, Output) :- spell_block(Val, 100, 999, "hundred", Output), !.
say(Val, Output) :- spell_block(Val, 1000, 999999, "thousand", Output), !.
say(Val, Output) :- spell_block(Val, 1000000, 999999999, "million", Output), !.
say(Val, Output) :- spell_block(Val, 1000000000, 999999999999, "billion", Output).

spell_units_only(U, 0, Label, OutStr) :-
    say(U, UStr),
    format(string(OutStr), "~s ~s", [UStr, Label]), !.
spell_units_only(U, Rem, Label, OutStr) :-
    say(U, UStr),
    say(Rem, RStr),
    format(string(OutStr), "~s ~s ~s", [UStr, Label, RStr]).

spell_block(Value, Min, Max, Label, Final) :-
    between(Min, Max, Value),
    divmod(Value, Min, Q, R),
    spell_units_only(Q, R, Label, Final).
