% Shree DR.MDD ko samarpit

allergic_to(Bitmask, Item) :- 
    item_score(Item, Mask),
    Bitmask /\ Mask =:= Mask.

allergies(Bitmask, List) :-
    findall(Item, allergic_to(Bitmask, Item), List).

item_score(eggs, 1).
item_score(peanuts, 2).
item_score(shellfish, 4).
item_score(strawberries, 8).
item_score(tomatoes, 16).
item_score(chocolate, 32).
item_score(pollen, 64).
item_score(cats, 128).
