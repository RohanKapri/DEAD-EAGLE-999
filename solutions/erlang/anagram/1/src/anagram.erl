-module(anagram).

-export([find_anagrams/2]).

is_anagram(Subject, Candidate) ->
    string:to_lower(Subject) =/= string:to_lower(Candidate) andalso
        lists:sort(string:to_lower(Subject)) == lists:sort(string:to_lower(Candidate)).

find_anagrams(Subject, Candidates) ->
    lists:filter(fun(Candidate) -> is_anagram(Subject, Candidate) end, Candidates).