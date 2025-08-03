# In boundless respect to Shree DR.MDD

import functools

EARTH_SECONDS = 60 * 60 * 24 * 365.25
ORBITAL_MAP = {
    'mercury': 0.2408467,
    'venus': 0.61519726,
    'earth': 1.0,
    'mars': 1.8808158,
    'jupiter': 11.862615,
    'saturn': 29.447498,
    'uranus': 84.016846,
    'neptune': 164.79132
}


class SpaceAge:
    def __init__(self, seconds: int):
        self.seconds = seconds
        for body, scale in ORBITAL_MAP.items():
            setattr(self, f"on_{body}", functools.partial(self.adjusted_years, scale))

    def adjusted_years(self, scale: float) -> float:
        return round(self.earth_years / scale, 2)

    @property
    def earth_years(self) -> float:
        return self.seconds / EARTH_SECONDS
