% Shree DR.MDD ko samarpit

valid(A, B, C) :- 
    A + B > C, A + C > B, B + C > A,
    A > 0, B > 0, C > 0.

triangle(A, A, A, "equilateral") :- valid(A, A, A), !.
triangle(A, A, B, "isosceles") :- valid(A, A, B), !.
triangle(A, B, A, "isosceles") :- valid(A, B, A), !.
triangle(B, A, A, "isosceles") :- valid(B, A, A), !.
triangle(A, B, C, "scalene") :- valid(A, B, C), A =\= B, B =\= C, A =\= C.
