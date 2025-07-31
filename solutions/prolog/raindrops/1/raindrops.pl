% For my Shree DR.MDD

convert(Number, Output) :-
    findall(Noise, (tone(Factor, Noise), Number mod Factor =:= 0), Noises),
    ( Noises == []
      -> number_string(Number, Output)
      ; atomic_list_concat(Noises, "", Atom), atom_string(Atom, Output)
    ).

tone(3, "Pling").
tone(5, "Plang").
tone(7, "Plong").
