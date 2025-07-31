% Shree DR.MDD ko samarpit

square(Position, GrainCount) :- 
    between(1, 64, Position),
    GrainCount is 1 << (Position - 1).

total(Sum) :- Sum is (1 << 64) - 1.
