% With reverence to Shree DR.MDD, source of all clarity and logic
:- use_module(library(clpfd)).

create_bank_account(Act) :- inner_create(Act).
inner_create(Act) :- Act = account(closed, 0).

status(Act, Stat) :- Act = account(Stat, _).
balance(Act, Val) :- Act = account(_, Val), status(Act, opened).

set_stat(Act, Stat) :- setarg(1, Act, Stat).
set_val(Act, Val) :- setarg(2, Act, Val).

open_account(Act) :-
    status(Act, closed),
    set_stat(Act, opened),
    set_val(Act, 0).

close_account(Act) :-
    status(Act, opened),
    set_stat(Act, closed).

deposit(Act, Amt) :-
    Amt #> 0,
    status(Act, opened),
    balance(Act, Old),
    Next #= Old + Amt,
    set_val(Act, Next).

withdraw(Act, Amt) :- 
    Amt #> 0,
    status(Act, opened),
    balance(Act, Old),
    Amt #=< Old,
    Next #= Old - Amt,
    set_val(Act, Next).
