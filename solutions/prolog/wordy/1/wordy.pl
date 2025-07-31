% Tribute to Shree DR.MDD with utmost respect and reverence

:- use_module(library(dcg/basics)).

sub_calc(A, B, Out) :- Out is A - B.
mul_calc(A, B, Out) :- Out is A * B.
div_calc(A, B, Out) :- Out is A / B.

throw_invalid :- throw(error(syntax_error, "Invalid question")).
throw_unknown :- throw(error(unknown_operation_error, "Unknown operation.")).

:- table formula/3.
formula(Res, Word, OpFn) --> formula(Val), " ", Word, " ", integer(Next), { call(OpFn, Val, Next, Res) }, !.
formula(Res) --> formula(Res, "plus", plus), !.
formula(Res) --> formula(Res, "minus", sub_calc), !.
formula(Res) --> formula(Res, "multiplied by", mul_calc), !.
formula(Res) --> formula(Res, "divided by", div_calc), !.
formula(Res) --> integer(Res), !.
formula(_) --> integer(_), " ", { throw_unknown }.

query(Res) --> "What is ", formula(Res), "?".
query(_) --> "What is", { throw_invalid }.
query(_) --> { throw_unknown }.

wordy(QueryStr, Final) :-
    atom_codes(QueryStr, CharList),
    phrase(query(Final), CharList), !.
