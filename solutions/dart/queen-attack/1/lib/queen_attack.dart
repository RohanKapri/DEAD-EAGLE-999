class Queen {
  Queen(this.x, this.y)
      : assert(!x.isNegative, 'row not positive'),
        assert(x < 8, 'row not on board'),
        assert(!y.isNegative, 'column not positive'),
        assert(y < 8, 'column not on board');

  final int x, y;

  bool canAttack(Queen opponent) =>
      isSameRow(opponent) || isSameCol(opponent) || isDiagonalTo(opponent);

  bool isSameRow(Queen opponent) => y == opponent.y;

  bool isSameCol(Queen opponent) => x == opponent.x;

  bool isDiagonalTo(Queen opponent) =>
      (opponent.x - x).abs() == (opponent.y - y).abs();
}