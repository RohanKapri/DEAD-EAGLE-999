pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  case queen {
    Position(row: row, column: column) if row < 0 -> Error(RowTooSmall)
    Position(row: row, column: column) if row > 7 -> Error(RowTooLarge)
    Position(row: row, column: column) if column < 0 -> Error(ColumnTooSmall)
    Position(row: row, column: column) if column > 7 -> Error(ColumnTooLarge)
    _ -> Ok(Nil)
  }
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  // Same row
  case black_queen.row == white_queen.row {
    True -> True
    False -> {
      // Same column
      case black_queen.column == white_queen.column {
        True -> True
        False -> {
          // Check diagonals
          let row_diff = black_queen.row - white_queen.row
          let column_diff = black_queen.column - white_queen.column
          row_diff == column_diff || row_diff == -column_diff
        }
      }
    }
  }
}