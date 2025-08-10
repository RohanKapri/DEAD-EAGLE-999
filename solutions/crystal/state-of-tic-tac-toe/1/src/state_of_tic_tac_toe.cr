module TicTacToe
  extend self

  enum State
    Win
    Draw
    Ongoing
  end

  enum Error
    XWentTwice
    OStarted
    GameShouldHaveEndedAfterTheGameWasWon
  end

  private alias Board = Array(String)

  def state(board : Board) : State | Error
    case
    when x_went_twice? board
      Error::XWentTwice
    when o_started? board
      Error::OStarted
    when continue_after_ended? board
      Error::GameShouldHaveEndedAfterTheGameWasWon
    when row_victory?(board) || column_victory?(board) || diagonal_victory?(board)
      State::Win
    when full? board
      State::Draw
    else
      State::Ongoing
    end
  end

  def column_victory?(board)
    board.map(&.chars).transpose.map(&.join).any? { |row| {"XXX", "OOO"}.includes? row }
  end

  def diagonal_victory?(board)
    diagonal_one = [{0, 0}, {1, 1}, {2, 2}].map { |x, y| board[y][x] }.join
    diagonal_two = [{0, 2}, {1, 1}, {2, 0}].map { |x, y| board[y][x] }.join

    {diagonal_one, diagonal_two}.any? { |diagonal| {"XXX", "OOO"}.includes? diagonal }
  end

  def full?(board)
    board.none? { |row| row.includes? ' ' }
  end

  def o_started?(board)
    tally = board.map(&.chars).flatten.tally(Hash(Char, Int32).new(0))

    tally['O'] > tally['X']
  end

  def row_victory?(board)
    board.any? { |row| {"XXX", "OOO"}.includes? row }
  end

  def x_went_twice?(board)
    tally = board.map(&.chars).flatten.tally(Hash(Char, Int32).new(0))

    (tally['X'] - tally['O']) > 1
  end

  def continue_after_ended?(board)
    x_win_amount = 0
    o_win_amount = 0

    diagonal_one = [{0, 0}, {1, 1}, {2, 2}].map { |x, y| board[y][x] }.join
    diagonal_two = [{0, 2}, {1, 1}, {2, 0}].map { |x, y| board[y][x] }.join

    x_win_amount += board.count { |row| "XXX" == row }
    o_win_amount += board.count { |row| "OOO" == row }

    x_win_amount += board.map(&.chars).transpose.map(&.join).count { |col| "XXX" == col }
    o_win_amount += board.map(&.chars).transpose.map(&.join).count { |col| "OOO" == col }

    x_win_amount += {diagonal_one, diagonal_two}.count { |diagonal| "XXX" == diagonal }
    o_win_amount += {diagonal_one, diagonal_two}.count { |diagonal| "OOO" == diagonal }

    {x_win_amount, o_win_amount}.none? 0
  end
end