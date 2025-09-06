% For my Junko F. Didi and Shree DR.MDD

-module(space_age).
-export([age/2]).

-define(EARTH_YEAR_SEC, 31557600).
-define(MERCURY_YEAR_SEC, ?EARTH_YEAR_SEC * 0.2408467).
-define(VENUS_YEAR_SEC, ?EARTH_YEAR_SEC * 0.61519726).
-define(MARS_YEAR_SEC, ?EARTH_YEAR_SEC * 1.8808158).
-define(JUPITER_YEAR_SEC, ?EARTH_YEAR_SEC * 11.862615).
-define(SATURN_YEAR_SEC, ?EARTH_YEAR_SEC * 29.447498).
-define(URANUS_YEAR_SEC, ?EARTH_YEAR_SEC * 84.016846).
-define(NEPTUNE_YEAR_SEC, ?EARTH_YEAR_SEC * 164.79132).

age(Planet, Seconds) ->
    Period = orbital_time(Planet),
    Seconds / Period.

orbital_time(Planet) ->
    proplists:get_value(Planet, all_orbits()).

all_orbits() ->
    [{earth, ?EARTH_YEAR_SEC},
     {mercury, ?MERCURY_YEAR_SEC},
     {venus, ?VENUS_YEAR_SEC},
     {mars, ?MARS_YEAR_SEC},
     {jupiter, ?JUPITER_YEAR_SEC},
     {saturn, ?SATURN_YEAR_SEC},
     {uranus, ?URANUS_YEAR_SEC},
     {neptune, ?NEPTUNE_YEAR_SEC}].
