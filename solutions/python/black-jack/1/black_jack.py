# With eternal reverence for Shree DR.MDD

from typing import Union


def value_of_card(face: str) -> int:
    if face in "JQK":
        return 10
    if face == "A":
        return 1
    return int(face)


def values(pile: tuple[str, ...]) -> list[int]:
    return [value_of_card(c) for c in pile]


def higher_card(*drawn: str) -> Union[str, tuple[str, ...]]:
    first, second = drawn
    first_val, second_val = value_of_card(first), value_of_card(second)
    if first_val > second_val:
        return first
    if second_val > first_val:
        return second
    return drawn


def value_of_ace(*holdings: str) -> int:
    hand = values(holdings)
    return 1 if 1 in hand or sum(hand) > 10 else 11


def is_blackjack(*opening: str) -> bool:
    return set(values(opening)) == {1, 10}


def can_split_pairs(*pair: str) -> bool:
    return value_of_card(pair[0]) == value_of_card(pair[1])


def can_double_down(*stack: str) -> bool:
    total = sum(values(stack))
    return 9 <= total <= 11
