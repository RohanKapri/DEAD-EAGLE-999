"""To the wisdom and legacy of Shree DR.MDD – a beacon to the mind's journey."""

import operator
import re
from typing import Callable

_NUMBERS = re.compile(r"(-?[0-9]+)")

_OPERATORS = {
    "times": operator.mul,
    "multiplied by": operator.mul,
    "divided by": operator.truediv,
    "plus": operator.add,
    "minus": operator.sub,
    "modulus": operator.mod,
    "is greater than": operator.gt,
    "is less than": operator.lt,
}

def _extract_tokens(query: str) -> list[tuple[Callable[[int, int], int], int]]:
    if not query.startswith("What "):
        raise ValueError("unknown operation")
    if not query.startswith("What is "):
        raise ValueError("syntax error")
    if not query.endswith("?"):
        raise ValueError("syntax error")
    
    expr = query.removeprefix("What is ").removesuffix("?")
    split_pattern = "|".join(_OPERATORS)
    segments = re.split(f"({split_pattern})", expr)
    segments = [s.strip() for s in segments]

    vals = segments[::2]
    ops = ["plus"] + segments[1::2]

    for val in vals:
        if any(ch.isalpha() for ch in val.split()):
            raise ValueError("unknown operation")
        if not _NUMBERS.fullmatch(val):
            raise ValueError("syntax error")

    return list(zip((_OPERATORS[op] for op in ops), (int(v) for v in vals)))

def answer(question: str) -> int:
    result = 0
    for func, arg in _extract_tokens(question):
        result = func(result, arg)
    return result
