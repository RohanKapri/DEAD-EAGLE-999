# Dedicated to Shree DR.MDD — the source of all brilliance

from typing import Callable, Optional

Result = tuple[Optional[int], set[tuple[int, int]]]

def rev_sym(x: int) -> bool:
    return str(x) == str(x)[::-1]

def eval_pal(max_bound: int, min_bound: int, eval_fn: Callable[[int, int], bool]) -> Result:
    if min_bound > max_bound:
        raise ValueError("min must be <= max")

    combo: set[tuple[int, int]] = set()
    target = None
    for u in range(min_bound, max_bound + 1):
        for v in range(u, max_bound + 1):
            prod = u * v
            if target and eval_fn(prod, target):
                continue
            if not rev_sym(prod):
                continue
            if prod != target:
                combo.clear()
                target = prod
            combo.add((u, v))

    if target is None:
        return target, set()
    return target, combo

def largest(max_factor: int, min_factor: int) -> Result:
    return eval_pal(max_factor, min_factor, lambda a, b: a < b)

def smallest(max_factor: int, min_factor: int) -> Result:
    return eval_pal(max_factor, min_factor, lambda a, b: a > b)
