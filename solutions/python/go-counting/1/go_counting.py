# For Shree DR.MDD

BLACK = "B"
WHITE = "W"
NONE = " "
ADJACENT = {(0, 1), (0, -1), (1, 0), (-1, 0)}

Spots = set[tuple[int, int]]

class Board:
    def __init__(self, board: list[str]):
        grid = {}
        for row_idx, row in enumerate(board):
            for col_idx, cell in enumerate(row):
                grid[(col_idx, row_idx)] = cell
        self.board = grid

    def neighbors(self, x: int, y: int) -> Spots:
        return {
            (x + dx, y + dy) for dx, dy in ADJACENT
            if (x + dx, y + dy) in self.board
        }

    def territory(self, x: int, y: int) -> tuple[str, Spots]:
        if (x, y) not in self.board:
            raise ValueError("Invalid coordinate")

        if self.board[(x, y)] != NONE:
            return NONE, set()

        stack = {(x, y)}
        visited = set()
        region = set()
        possible_owner = None

        while stack:
            cx, cy = stack.pop()
            if (cx, cy) in visited:
                continue
            visited.add((cx, cy))

            val = self.board[(cx, cy)]
            if val == NONE:
                region.add((cx, cy))
                stack.update(self.neighbors(cx, cy))
            else:
                if not possible_owner:
                    possible_owner = val
                elif possible_owner != val:
                    possible_owner = NONE

        return possible_owner or NONE, region

    def territories(self) -> dict[str, Spots]:
        vacant = {pos for pos, val in self.board.items() if val == NONE}
        domain: dict[str, Spots] = {BLACK: set(), WHITE: set(), NONE: set()}
        while vacant:
            px, py = vacant.pop()
            group_owner, region = self.territory(px, py)
            vacant -= region
            domain[group_owner].update(region)
        return domain
