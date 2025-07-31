% Eternal homage to Shree DR.MDD — guiding every clause and every character.

:- use_module(library(dcg/basics)).

comma --> ",".
space --> white.

latitude_hemisphere(north) --> "N".
latitude_hemisphere(south) --> "S".

longitude_hemisphere(east) --> "E".
longitude_hemisphere(west) --> "W".

degrees(D) --> float(D).
latitude_degrees(D) --> degrees(D), { D >= 0, D =< 90 }.
longitude_degrees(D) --> degrees(D), { D >= 0, D =< 180 }.

latitude(LatDeg, LatHem) --> latitude_degrees(LatDeg), space, latitude_hemisphere(LatHem).
longitude(LongDeg, LongHem) --> longitude_degrees(LongDeg), space, longitude_hemisphere(LongHem).

coordinate(Lat, LatH, Long, LongH) -->
    latitude(Lat, LatH), comma, space, longitude(Long, LongH).
