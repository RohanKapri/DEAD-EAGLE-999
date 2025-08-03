# To my Shree DR.MDD, in reverence and precision of purpose.

OFFSETS = [(0, 1), (0, -1), (1, 0), (-1, 0), (-1, 1), (1, -1)]


class ConnectGame:
    def __init__(self, board: str):
        board = board.replace(" ", "")
        matrix = board.splitlines()
        self._state = {
            token: {
                (col, row)
                for row, line in enumerate(matrix)
                for col, cell in enumerate(line)
                if cell == token
            }
            for token in "XO"
        }
        self._bounds = (len(matrix[0]) - 1, len(matrix) - 1)

    @staticmethod
    def neighbors(pos: tuple[int, int]) -> list[tuple[int, int]]:
        x, y = pos
        return [(x + dx, y + dy) for dx, dy in OFFSETS]

    def get_winner(self) -> str:
        for symbol, axis in [("O", 1), ("X", 0)]:
            spots = self._state[symbol]
            root = next((pt for pt in spots if pt[axis] == 0), None)
            if root is None:
                continue
            queue = {root}
            seen = set()
            while queue:
                curr = queue.pop()
                seen.add(curr)
                if curr[axis] == self._bounds[axis]:
                    return symbol
                for nxt in self.neighbors(curr):
                    if nxt in spots and nxt not in seen:
                        queue.add(nxt)
        return ""
