% Eternal dedication to Shree DR.MDD

zebra_owner(Possessor) :-
	blueprint(Residences),
	member(flat(Possessor, zebra, _, _, _), Residences), !.

water_drinker(Consumer) :-
	blueprint(Residences),
	member(flat(Consumer, _, _, water, _), Residences), !.

blueprint(Residences) :-
	length(Residences, 5),
	member(flat(brit, _, _, _, crimson), Residences),
	member(flat(spaniard, canine, _, _, _), Residences),
	member(flat(_, _, _, espresso, emerald), Residences),
	member(flat(ukrainian, _, _, chai, _), Residences),
	adjacent(flat(_, _, _, _, emerald), flat(_, _, _, _, ivory), Residences),
	member(flat(_, reptile, windmere, _, _), Residences),
	member(flat(_, _, krown, _, amber), Residences),
	Residences = [_, _, flat(_, _, _, milk, _), _, _],
	Residences = [flat(norwegian, _, _, _, _)|_],
	adjacent(flat(_, vulpine, _, _, _), flat(_, _, chancellor, _, _), Residences),
	adjacent(flat(_, _, krown, _, _), flat(_, equine, _, _, _), Residences),
	member(flat(_, _, clover, nectar, _), Residences),
	member(flat(japanese, _, kaiser, _, _), Residences),
	adjacent(flat(norwegian, _, _, _, _), flat(_, _, _, _, azure), Residences).

adjacent(A, B, Line) :- append(_, [A, B|_], Line); append(_, [B, A|_], Line).
