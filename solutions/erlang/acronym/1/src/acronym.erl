-module(acronym).
-export([abbreviate/1]).
abbreviate(Phrase) ->
	parse(Phrase, true, "").
parse([$\s|Str], _, Acc) ->
	parse(Str, true, Acc);
parse([$-|Str], _, Acc) ->
	parse(Str, true, Acc);
parse([C|Str], true, Acc) when C>=$A, C=<$Z ->
	parse(Str, false, [C|Acc]);
parse([C|Str], true, Acc) when C>=$a, C=<$z ->
	parse(Str, false, [C-$a+$A|Acc]);
parse([_|Str], ExpectChar, Acc) ->
	parse(Str, ExpectChar, Acc);
parse([], _, Acc) ->
	lists:reverse(Acc).