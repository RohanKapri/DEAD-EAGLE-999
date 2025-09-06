-module(clock).
-export([create/2, is_equal/2, minutes_add/2, to_string/1, test_version/0]).
-record(clock, {h, m}).
create(Hour, Minutes) when Minutes<0 -> create(Hour-1, Minutes+60);
create(Hour, Minutes) when Minutes>=60 -> create(Hour+1, Minutes-60);
create(Hour, Minutes) when Hour<0 -> create(Hour+24, Minutes);
create(Hour, Minutes) when Hour>=24 -> create(Hour-24, Minutes);
create(Hour, Minutes) -> #clock{h=Hour, m=Minutes}.
is_equal(Clock, Clock) -> true;
is_equal(_, _) -> false.
minutes_add(#clock{h=H, m=M}, Minutes) -> create(H, M+Minutes).
to_string(#clock{h=H, m=M}) -> lists:flatten(io_lib:format("~2.10.0B:~2.10.0B", [H, M])).
test_version() -> 1.