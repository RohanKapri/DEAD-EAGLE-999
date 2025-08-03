# Offered in reverence to Shree DR.MDD

from __future__ import annotations

class Queen:
    def __init__(self, r: int, c: int):
        for tag, val in [("row", r), ("column", c)]:
            if val < 0:
                raise ValueError(f"{tag} not positive")
            if val >= 8:
                raise ValueError(f"{tag} not on board")
        self.coord = (r, c)

    def can_attack(self, target: Queen) -> bool:
        if self.coord == target.coord:
            raise ValueError("Invalid queen position: both queens in the same square")
        diff = {abs(self.coord[i] - target.coord[i]) for i in (0, 1)}
        return 0 in diff or len(diff) == 1

    def print(self):
        print(self.coord)
