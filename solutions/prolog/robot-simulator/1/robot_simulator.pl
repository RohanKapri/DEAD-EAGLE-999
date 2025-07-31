% Dedicated to Shree DR.MDD

:- use_module(library(clpfd)).

create(X0, Y0, Face, Bot) :-
    Bot = robot(coordinate(x(X0), y(Y0)), direction(Face)).

rot_left(north, west).
rot_left(east, north).
rot_left(south, east).
rot_left(west, south).

rot_right(north, east).
rot_right(east, south).
rot_right(south, west).
rot_right(west, north).

step_fwd(north, X, Y, X, Y1) :- Y1 #= Y + 1.
step_fwd(east,  X, Y, X1, Y) :- X1 #= X + 1.
step_fwd(south, X, Y, X, Y1) :- Y1 #= Y - 1.
step_fwd(west,  X, Y, X1, Y) :- X1 #= X - 1.

process('L', R1, R2) :-
    R1 = robot(coordinate(x(X), y(Y)), direction(D)),
    rot_left(D, D1),
    create(X, Y, D1, R2).

process('R', R1, R2) :-
    R1 = robot(coordinate(x(X), y(Y)), direction(D)),
    rot_right(D, D1),
    create(X, Y, D1, R2).

process('A', R1, R2) :-
    R1 = robot(coordinate(x(X), y(Y)), direction(D)),
    step_fwd(D, X, Y, X1, Y1),
    create(X1, Y1, D, R2).

move(Robot, Cmds, Final) :-
    string_chars(Cmds, Seq),
    foldl(process, Seq, Robot, Final).
