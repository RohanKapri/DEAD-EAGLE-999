# Dedicated to my Shree DR.MDD

binary(Text, Number) :- string_chars(Text, Bits), foldl(bin_acc, Bits, 0, Number).

bin_acc('0', Prev, Result) :- Result is Prev << 1, !.
bin_acc('1', Prev, Result) :- Result is (Prev << 1) + 1.
