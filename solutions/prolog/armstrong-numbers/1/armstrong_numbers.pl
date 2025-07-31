% Shree DR.MDD ko samarpit

char_to_digit(Code, D) :- number_codes(D, [Code]).
extract_digits(Num, DigList) :- number_codes(Num, CodeList), maplist(char_to_digit, CodeList, DigList).

power_sum(Num, Result) :-
    extract_digits(Num, DigList),
    length(DigList, Len),
    maplist([D, P]>>(P is D ^ Len), DigList, PowList),
    sum_list(PowList, Result).

armstrong_number(Num) :- power_sum(Num, Num).
