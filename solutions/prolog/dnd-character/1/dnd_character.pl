modifier(Score, Modifier) :-
    Modifier is floor((Score - 10) / 2).

ability(Score) :-
    maplist(random(1, 7), Nums),
    sort(0, @>=, Nums, [N1,N2,N3,_]),
    Score is N1 + N2 + N3.

create_character(character(strength(S),
                           dexterity(D),
                           constitution(Co),
                           intelligence(I),
                           wisdom(W),
                           charisma(Ch),
                           hitpoints(H)
                          )) :-
    maplist(ability, [S,D,Co,I,W,Ch]),
    modifier(Co, Mod),
    H is 10 + Mod.