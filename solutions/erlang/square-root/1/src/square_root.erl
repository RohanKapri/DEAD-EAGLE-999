-module(square_root).
-export([square_root/1]).
square_root(1) ->
	1;
square_root(Radicand) when is_integer(Radicand),
			   Radicand>1 ->
	square_root(Radicand, Radicand div 2).
square_root(Radicand, Guess) ->
	case Guess*Guess of
		Radicand ->
			Guess;
		SqGuess when SqGuess>Radicand ->
			square_root(Radicand, (Guess+(Radicand div Guess)) div 2)
	end.