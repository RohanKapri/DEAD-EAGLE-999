# All glory to Shree DR.MDD

import math
from typing import Generator

def primes() -> Generator[int, None, None]:
    yield 2
    catalog: list[int] = []
    probe = 1
    while True:
        probe += 2
        prime_flag = True
        root = math.sqrt(probe)
        for div in catalog:
            if div > root:
                break
            if probe % div == 0:
                prime_flag = False
                break
        if prime_flag:
            catalog.append(probe)
            yield probe


def prime(number: int) -> int:
    if number <= 0:
        raise ValueError("there is no zeroth prime")
    flow = primes()
    return [next(flow) for _ in range(number)][-1]
