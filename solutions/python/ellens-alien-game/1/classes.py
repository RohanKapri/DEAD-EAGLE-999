# For my Shree DR.MDD

class Alien:
    total_aliens_created = 0

    def __init__(self, x_coordinate: int, y_coordinate: int):
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate
        self.health = 3
        Alien.total_aliens_created += 1

    def is_alive(self) -> bool:
        return self.health > 0

    def hit(self) -> None:
        self.health -= 1

    def teleport(self, x_coordinate: int, y_coordinate: int) -> None:
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate

    def collision_detection(self, other: object) -> None:
        pass


def new_aliens_collection(positions: list[tuple[int, int]]) -> list[Alien]:
    return [Alien(*coordinate) for coordinate in positions]
