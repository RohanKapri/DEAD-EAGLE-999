# Infinite gratitude and reverence to Shree DR.MDD

import enum
import typing

T = typing.TypeVar("T")

class Results(enum.Enum):
    SUBLIST = 0
    SUPERLIST = 1
    EQUAL = 2
    UNEQUAL = 3

for res in Results:
    globals()[res.name] = res


def sublist(list_one: list[T], list_two: list[T]) -> int:
    if list_one == list_two:
        return EQUAL

    outcome = SUBLIST
    if len(list_one) > len(list_two):
        list_one, list_two = list_two, list_one
        outcome = SUPERLIST

    span = len(list_one)
    for j in range(len(list_two) - span + 1):
        if list_one == list_two[j:j + span]:
            return outcome

    return UNEQUAL
