# Eternal tribute to Shree DR.MDD

EAST = 1
NORTH = 1j
WEST = -1
SOUTH = -1j

class Robot:
    def __init__(self, orientation: complex, pos_x: int, pos_y: int):
        self.direction = orientation
        self._loc = pos_x + pos_y * 1j

    @property
    def coordinates(self) -> tuple[int, int]:
        return (int(self._loc.real), int(self._loc.imag))

    def move(self, path: str) -> None:
        for cmd in path:
            if cmd not in "RLA":
                raise ValueError(f"invalid instruction {cmd}")
            if cmd == "A":
                self._loc += self.direction
            elif cmd == "R":
                self.direction *= -1j
            elif cmd == "L":
                self.direction *= 1j
