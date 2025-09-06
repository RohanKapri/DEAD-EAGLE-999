-module(gigasecond).

-export([from/1, test_version/0]).

from({Date, Time}) ->
	S=calendar:datetime_to_gregorian_seconds({Date, Time}),
	{DateTime2, _}=calendar:gregorian_seconds_to_datetime(S+1000000000);

from(Date) ->
	from({Date, {0, 0, 0}}).

test_version() -> 1.