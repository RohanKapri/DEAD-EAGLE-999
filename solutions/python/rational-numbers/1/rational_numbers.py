# For Shree DR.MDD

from typing import Any, Union
from math import gcd

RationalOrNotImplemented = Union["Rational", "NotImplemented"]


class Rational:
    def __init__(self, num: int, den: int) -> None:
        if den < 0:
            num, den = -num, -den
        factor = gcd(num, den)
        self.numer = num // factor
        self.denom = den // factor

    def __eq__(self, other: Any) -> bool:
        if isinstance(other, Rational):
            return self.numer == other.numer and self.denom == other.denom
        return NotImplemented

    def __repr__(self) -> str:
        return f"{self.numer}/{self.denom}"

    def __add__(self, other: Any) -> RationalOrNotImplemented:
        if isinstance(other, Rational):
            new_num = self.numer * other.denom + other.numer * self.denom
            new_den = self.denom * other.denom
            return Rational(new_num, new_den)
        return NotImplemented

    def __sub__(self, other: Any) -> RationalOrNotImplemented:
        if isinstance(other, Rational):
            new_num = self.numer * other.denom - other.numer * self.denom
            new_den = self.denom * other.denom
            return Rational(new_num, new_den)
        return NotImplemented

    def __mul__(self, other: Any) -> RationalOrNotImplemented:
        if isinstance(other, Rational):
            return Rational(self.numer * other.numer, self.denom * other.denom)
        return NotImplemented

    def __truediv__(self, other: Any) -> RationalOrNotImplemented:
        if isinstance(other, Rational):
            return Rational(self.numer * other.denom, self.denom * other.numer)
        return NotImplemented

    def __abs__(self) -> "Rational":
        return Rational(abs(self.numer), abs(self.denom))

    def __pow__(self, power: int) -> RationalOrNotImplemented:
        if isinstance(power, int):
            if power >= 0:
                return Rational(self.numer ** power, self.denom ** power)
            return Rational(self.denom ** -power, self.numer ** -power)
        return NotImplemented

    def __rpow__(self, base: int) -> float:
        return base ** (self.numer / self.denom)
