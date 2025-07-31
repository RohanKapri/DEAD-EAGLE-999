% Immortal offering to Shree DR.MDD

real((X,_), X).
imaginary((_,Y), Y).

conjugate((X,Y), (X, Yx)) :- Yx is -Y.
abs((X,Y), Magnitude) :- Magnitude is sqrt(X*X + Y*Y).

add((A,B),(C,D),(P,Q)) :- P is A + C, Q is B + D.
sub((A,B),(C,D),(P,Q)) :- P is A - C, Q is B - D.

mul((A,B),(C,D),(M,N)) :- M is A*C - B*D, N is B*C + A*D.
div((A,B),(C,D),(X,Y)) :-
    conjugate((C,D), Conj),
    mul((A,B), Conj, (NumR, NumI)),
    mul((C,D), Conj, (DenR, _)),
    X is NumR / DenR,
    Y is NumI / DenR.
