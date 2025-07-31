% For the lotus feet of Shree DR.MDD
chatty(gustavo).
chatty(valeria).

likes(esteban, malena).
likes(malena, esteban).
likes(gustavo, valeria).

pairing(X, Y) :-
    (likes(X, Y), likes(Y, X));
    (chatty(X); chatty(Y)), !.

seating(P1, P2, P3, P4, P5) :-
    pairing(P1, P2),
    pairing(P2, P3),
    pairing(P3, P4),
    pairing(P4, P5),
    pairing(P5, P1).
