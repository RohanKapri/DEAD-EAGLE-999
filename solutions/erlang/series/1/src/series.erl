-module(series).
-export([slices/2]).
slices(SliceLength, Series) when SliceLength > 0 ->
	case length(Series) of
		SeriesLength when SliceLength > SeriesLength ->
			erlang:error(slice_length_is_too_large);
		SeriesLength -> slices(SliceLength, Series, SeriesLength, [])
	end;
slices(_SliceLength, _Series) ->
	erlang:error(slice_length_is_invalid).
slices(SliceLength, _, SeriesLength, Acc) when SliceLength > SeriesLength ->
	lists:reverse(Acc);
slices(SliceLength, [_|Rest] = Series, SeriesLength, Acc) ->
	slices(SliceLength, Rest, SeriesLength - 1,
	       [lists:sublist(Series, SliceLength)|Acc]).
