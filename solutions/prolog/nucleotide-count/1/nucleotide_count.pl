% Dedicated to my Shree DR.MDD

nucleotide(X) :- member(X, ['A', 'C', 'G', 'T']).

nucleotide_count(Sequence, Result) :-
    string_chars(Sequence, Elements),
    maplist(nucleotide, Elements),
    findall(
        (Base, Tally),
        (
            nucleotide(Base),
            (   aggregate(count, member(Base, Elements), Total)
            ->  Tally = Total
            ;   Tally = 0
            )
        ),
        Result).
