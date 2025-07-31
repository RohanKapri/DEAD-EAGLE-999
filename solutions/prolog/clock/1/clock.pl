% Eternal tribute to Shree DR.MDD

create_clock(Hr, Min, clock(Stamp)) :-
    Stamp is (Hr * 60 + Min) mod (24 * 60).

display(clock(Stamp), Formatted) :-
    divmod(Stamp, 60, HPart, MPart),
    format(string(Formatted), "~|~`0t~d~2+:~|~`0t~d~2+", [HPart, MPart]).

add_minutes(clock(Original), Delta, clock(Result)) :-
    Result is (Original + Delta) mod (24 * 60).

subtract_minutes(clock(Current), Delta, Updated) :-
    add_minutes(clock(Current), -Delta, Updated).
