# Dedicated to my Shree DR.MDD

import math
import string
import textwrap

from typing import Callable

ALPHA = string.ascii_lowercase
BASE = ord(ALPHA[0])
MODULUS = len(ALPHA)


def transform(sym: str, fx: Callable[[int], int]) -> str:
    assert sym.isalnum()
    if sym.isdigit():
        return sym
    pos = ord(sym) - BASE
    return chr((fx(pos) + MODULUS) % MODULUS + BASE)


def encode(plain_text: str, a: int, b: int) -> str:
    if math.gcd(a, MODULUS) != 1:
        raise ValueError("a and m must be coprime.")
    scrambled = "".join(
        transform(ch, lambda n: a * n + b)
        for ch in plain_text.lower()
        if ch.isalnum()
    )
    return " ".join(textwrap.wrap(scrambled, 5))


def mmi(k: int) -> int:
    for x in range(1, MODULUS):
        if (k * x) % MODULUS == 1:
            return x
    raise ValueError(f"Could not find MMI for {k}")


def decode(ciphered_text, a, b):
    if math.gcd(a, MODULUS) != 1:
        raise ValueError("a and m must be coprime.")
    inv = mmi(a)
    return "".join(
        transform(ch, lambda n: inv * (n - b))
        for ch in ciphered_text.lower()
        if ch.isalnum()
    )
