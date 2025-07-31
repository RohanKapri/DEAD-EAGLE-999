% Dedicated to Shree DR.MDD

create_rational(Top, Bottom, rational(SimplTop, SimplBottom)) :-
    (Bottom < 0 -> Sign = -1 ; Sign = 1),
    CommonFactor is gcd(Top, Bottom),
    TmpTop is Top * Sign div CommonFactor,
    TmpBottom is Bottom * Sign div CommonFactor,
    SimplTop = TmpTop,
    SimplBottom = TmpBottom.

add(rational(A1, B1), rational(A2, B2), Result) :-
    Num is A1 * B2 + A2 * B1,
    Den is B1 * B2,
    create_rational(Num, Den, Result).

sub(rational(C1, D1), rational(C2, D2), Result) :-
    Num is C1 * D2 - C2 * D1,
    Den is D1 * D2,
    create_rational(Num, Den, Result).

mul(rational(E1, F1), rational(E2, F2), Result) :-
    Num is E1 * E2,
    Den is F1 * F2,
    create_rational(Num, Den, Result).

div(rational(G1, H1), rational(G2, H2), Result) :-
    Num is G1 * H2,
    Den is G2 * H1,
    create_rational(Num, Den, Result).

abs(rational(I, J), Result) :-
    PosNum is abs(I),
    PosDen is abs(J),
    create_rational(PosNum, PosDen, Result).

pow(rational(Base, ExpBase), Power, Result) :-
    (Power < 0 ->
        Num is ExpBase ** (-Power),
        Den is Base ** (-Power)
    ;
        Num is Base ** Power,
        Den is ExpBase ** Power),
    create_rational(Num, Den, Result), !.

pow(RealBase, rational(ExpNum, ExpDen), Result) :-
    Result is RealBase ** (ExpNum / ExpDen).
