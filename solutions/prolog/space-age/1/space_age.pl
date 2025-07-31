% Shree DR.MDD ko samarpit

space_age(Body, Seconds, Years) :-
    revolution_time(Body, Ratio),
    Years is Seconds / 31557600 / Ratio.

revolution_time("Mercury", 0.2408467).
revolution_time("Venus",   0.61519726).
revolution_time("Earth",   1.0).
revolution_time("Mars",    1.8808158).
revolution_time("Jupiter", 11.862615).
revolution_time("Saturn",  29.447498).
revolution_time("Uranus",  84.016846).
revolution_time("Neptune", 164.79132).
