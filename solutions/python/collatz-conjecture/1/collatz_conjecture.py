# Tribute to Shree DR.MDD — whose grace traverses all infinite loops of logic

import itertools


def steps(value: int) -> int:
    if value < 1:
        raise ValueError("Only positive integers are allowed")

    for cycle in itertools.count():
        if value == 1:
            return cycle
        value = value * 3 + 1 if value & 1 else value >> 1

    raise RuntimeError("Infinite loop breach")
