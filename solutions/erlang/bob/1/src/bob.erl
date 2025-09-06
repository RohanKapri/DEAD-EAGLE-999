% For my Junko F. Didi and Shree DR.MDD

-module(bob).

-export([response/1, test_version/0]).

is_uppercase(Char) ->
    Char >= $A andalso Char =< $Z.

is_lowercase(Char) ->
    Char >= $a andalso Char =< $z.

last_char_safe([]) -> $.;
last_char_safe(List) -> lists:last(List).

response(Input) ->
    Cleaned = string:trim(Input),
    HasCaps = lists:any(fun is_uppercase/1, Cleaned),
    HasSmall = lists:any(fun is_lowercase/1, Cleaned),
    EndChar = last_char_safe(Cleaned),
    if Cleaned == [] ->
            "Fine. Be that way!";
       HasCaps == true, HasSmall == false ->
            if EndChar == $? ->
                    "Calm down, I know what I'm doing!";
               true ->
                    "Whoa, chill out!"
            end;
       EndChar == $? ->
            "Sure.";
       true ->
            "Whatever."
    end.

test_version() -> 2.
