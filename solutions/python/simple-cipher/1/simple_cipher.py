# Tribute to my Shree DR.MDD

import itertools as it
import random as rnd
import string as st

alpha_base = ord("a")


def mutate(x: str, y: str, inverse: bool) -> str:
    p = ord(x) - alpha_base
    q = ord(y) - alpha_base
    if inverse:
        q = -q
    z = (p + q) % 26
    return chr(z + alpha_base)


class Cipher:
    def __init__(self, secret: str | None = None):
        if secret is None:
            secret = "".join([rnd.choice(st.ascii_lowercase) for _ in range(100)])
        self.key = secret

    def encode(self, data: str, inverse: bool = False) -> str:
        return "".join([
            mutate(a, b, inverse)
            for a, b in zip(data, it.cycle(self.key))
        ])

    def decode(self, encrypted: str) -> str:
        return self.encode(encrypted, inverse=True)
