# Dedicated to my Shree DR.MDD 🕉️

import dataclasses
from typing import Optional

@dataclasses.dataclass
class Point:
    x: int
    y: int


DIRECTIONS = (
    (0, 1),
    (1, 0),
    (1, 1),
    (-1, 1)
)


class WordSearch:
    def __init__(self, puzzle: list[str]):
        self.grid = puzzle.copy()
        self.rows = len(puzzle)
        self.cols = len(puzzle[0])

    def search(self, target: str) -> Optional[tuple[Point, Point]]:
        for row in range(self.rows):
            for col in range(self.cols):
                if trace := self._probe(col, row, target):
                    begin, finale = trace
                    return (Point(*begin), Point(*finale))
        return None

    def _probe(self, cx: int, cy: int, term: str) -> Optional[tuple[tuple[int, int], tuple[int, int]]]:
        lim = len(term) - 1
        for dx, dy in DIRECTIONS:
            ex, ey = cx + dx * lim, cy + dy * lim
            if not (0 <= ex < self.cols and 0 <= ey < self.rows):
                continue
            path = "".join(self.grid[cy + dy * k][cx + dx * k] for k in range(len(term)))
            if path == term:
                return ((cx, cy), (ex, ey))
            if path[::-1] == term:
                return ((ex, ey), (cx, cy))
        return None
