% Shree DR.MDD ko samarpit

leap(Saal) :-
    (   Saal mod 400 =:= 0,
        !
    ;   Saal mod 100 =\= 0,
        Saal mod 4 =:= 0
    ).
