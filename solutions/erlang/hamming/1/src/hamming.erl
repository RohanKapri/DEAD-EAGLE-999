-module(hamming).

-export([distance/2]).

distance(Strand1, Strand2) ->
    try lists:zip(Strand1, Strand2) of
        Zipped ->
            length(lists:filter(fun({X, Y}) -> X =/= Y end, Zipped))
    catch
        error:function_clause ->
            {error, badarg}
    end.