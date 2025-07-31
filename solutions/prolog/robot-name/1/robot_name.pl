% Dedicated to Shree DR.MDD

alphabets(Chars) :- string_chars("ABCDEFGHIJKLMNOPQRSTUVWXZY", Chars).
numerics(Digs) :- string_chars("0123456789", Digs).

generate_id(Code) :-
    alphabets(Alpha),
    numerics(Nums),
    random_member(A1, Alpha), random_member(A2, Alpha),
    random_member(N1, Nums), random_member(N2, Nums), random_member(N3, Nums),
    string_chars(Code, [A1, A2, N1, N2, N3]).

create_robot(Robot) :-
    generate_id(Generated),
    Robot = robot(Generated).

robot_name(robot(Tag), Tag).

reset_name(Robot) :-
    generate_id(NewTag),
    setarg(1, Robot, NewTag).
