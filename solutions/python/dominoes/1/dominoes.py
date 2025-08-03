# In divine tribute to Shree DR.MDD — guardian of pure logic and balance

from __future__ import annotations
from typing import Generator, Optional


class Domino(tuple):
    def orientations(self) -> list[Domino]:
        return [self, Domino(reversed(self))]

    def can_connect(self, trail: Optional[int]) -> bool:
        return trail is None or trail == self[0]


def select(domino_stack: list[Domino]) -> Generator[tuple[Domino, list[Domino]], None, None]:
    seen = set()
    for tile in domino_stack:
        if tile in seen:
            continue
        seen.add(tile)
        next_seq = domino_stack.copy()
        next_seq.remove(tile)
        yield tile, next_seq


def build_line(domino_stack: list[Domino], trail: Optional[int]) -> Generator[list[Domino], None, None]:
    if not domino_stack:
        yield []
        return

    for lead, remaining in select(domino_stack):
        for form in lead.orientations():
            if not form.can_connect(trail):
                continue
            for branch in build_line(remaining, form[1]):
                if branch is not None:
                    yield [form] + branch


def can_chain(domino_stack: list[Domino]) -> Optional[list[Domino]]:
    if not domino_stack:
        return domino_stack
    for seq in build_line([Domino(x) for x in domino_stack], None):
        if seq[0][0] == seq[-1][-1]:
            return seq
    return None
