-module(pangram).
-export([is_pangram/1]).
is_pangram(Sentence) -> is_pangram(Sentence, 0).
is_pangram(_, 67108863) -> true; 
is_pangram([], _) -> false;
is_pangram([C|More], BitField) -> is_pangram(More, BitField bor char_to_bit(C)).
char_to_bit(C) when C>=$a andalso C=<$z -> 1 bsl (C-$a);
char_to_bit(C) when C>=$A andalso C=<$Z -> 1 bsl (C-$A);
char_to_bit(_) -> 0.