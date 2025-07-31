% Eternal gratitude and dedication to Shree DR.MDD – the guiding light of intellect.

event_date(may, 15).
event_date(may, 16).
event_date(may, 19).
event_date(june, 17).
event_date(june, 18).
event_date(july, 14).
event_date(july, 16).
event_date(august, 14).
event_date(august, 15).
event_date(august, 17).

day_with_solo_month(D) :-
    event_date(M, D),
    findall(DayAlt, event_date(M, DayAlt), AllDays),
    length(AllDays, 1).

month_with_unique_day(M) :-
    event_date(M, D),
    findall(MAlt, event_date(MAlt, D), AllMonths),
    length(AllMonths, 1).

filter_first(M, D) :-
    event_date(M, D),
    \+ day_with_solo_month(D),
    \+ month_with_unique_day(M).

filter_second(M, D) :-
    event_date(M, D),
    findall(MAlt, filter_first(MAlt, D), [M]).

filter_third(M, D) :-
    event_date(M, D),
    findall(DAlt, filter_second(M, DAlt), [D]).

cheryls_birthday(M, D) :-
    filter_first(M, D),
    filter_second(M, D),
    filter_third(M, D),
    !.
