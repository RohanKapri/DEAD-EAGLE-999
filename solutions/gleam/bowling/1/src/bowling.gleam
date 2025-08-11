import gleam/list
import gleam/result

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  case knocked_pins {
    0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 ->
      add_throw(game, knocked_pins)
      |> result.then(calc_bonus)
      |> result.then(game_end_check)

    _ -> Error(InvalidPinCount)
  }
}

fn add_throw(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  case game.frames {
    [] ->
      // first throw
      Ok(Game(frames: [Frame(rolls: [knocked_pins], bonus: [])]))
    [Frame(rolls: [10], bonus: []), ..] ->
      // last throw was a strike add new frame
      Ok(Game(frames: [Frame(rolls: [knocked_pins], bonus: []), ..game.frames]))
    [Frame(rolls: [f], bonus: []), ..rest] ->
      case { f + knocked_pins < 11 } {
        True ->
          // second throw
          Ok(Game(frames: [Frame(rolls: [f, knocked_pins], bonus: []), ..rest]))
        // no more than 10 pins fit a frame.
        False -> Error(InvalidPinCount)
      }
    [Frame(rolls: [_f, _s], bonus: []), ..] ->
      // previous frame is full, new frame
      Ok(Game(frames: [Frame(rolls: [knocked_pins], bonus: []), ..game.frames]))
    _ -> Error(GameComplete)
  }
}

fn calc_bonus(game: Game) -> Result(Game, Error) {
  Ok(Game(frames: do_calc_bonus(game.frames)))
}

fn do_calc_bonus(frames) -> List(Frame) {
  case frames {
    // strikes
    [
      Frame(rolls: [f], bonus: []),
      Frame(rolls: [10], bonus: []),
      Frame(rolls: [10], bonus: []),
      ..rest
    ] -> {
      [
        Frame(rolls: [f], bonus: []),
        Frame(rolls: [10], bonus: []),
        Frame(rolls: [10], bonus: [f, 10]),
        ..rest
      ]
    }

    [Frame(rolls: [f, s], bonus: []), Frame(rolls: [10], bonus: []), ..rest] -> {
      [
        Frame(rolls: [f, s], bonus: []),
        Frame(rolls: [10], bonus: [f, s]),
        ..rest
      ]
    }

    // spares
    [
      Frame(rolls: [third, ..fourth], bonus: []),
      Frame(rolls: [f, s], bonus: []),
      ..rest
    ] ->
      case f + s {
        10 -> // spare
        [
          Frame(rolls: [third, ..fourth], bonus: []),
          Frame(rolls: [f, s], bonus: [third]),
          ..rest
        ]
        _ -> frames
      }
    // no bonus situation found
    _ -> {
      frames
    }
  }
}

fn game_end_check(game: Game) -> Result(Game, Error) {
  case list.length(game.frames) {
    12 -> {
      case game.frames {
        // last roll strike
        [
          Frame(rolls: [_x], bonus: []),
          Frame(rolls: [10], bonus: []),
          Frame(rolls: [10], bonus: b),
          ..rest
        ] -> Ok(Game(frames: [Frame(rolls: [10], bonus: b), ..rest]))
        // not last roll strike
        [
          Frame(rolls: [10], bonus: []),
          Frame(rolls: [_x], bonus: []),
          Frame(rolls: [10], bonus: _b),
          ..
        ] ->
          // two_bonus_rolls_after_strike_in_last_frame_and_first_one_is_not_strike_test
          Error(InvalidPinCount)
        _ -> Error(GameComplete)
      }
    }

    11 -> {
      case game.frames {
        [Frame(rolls: [_f], bonus: []), Frame(rolls: [10], bonus: []), ..] ->
          // one more throw to go
          Ok(game)
        [
          Frame(rolls: [_f, _s], bonus: []),
          Frame(rolls: [10], bonus: b),
          ..rest
        ] -> Ok(Game(frames: [Frame(rolls: [10], bonus: b), ..rest]))
        // last role spare
        [
          Frame(rolls: [_spare], bonus: []),
          Frame(rolls: [f, s], bonus: b),
          ..rest
        ] ->
          case f + s {
            10 -> Ok(Game(frames: [Frame(rolls: [f, s], bonus: b), ..rest]))
            _ -> Error(GameComplete)
          }
        _ -> Error(GameComplete)
      }
    }
    0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 -> Ok(game)
    _ -> Error(GameComplete)
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  case list.length(game.frames) {
    10 -> {
      case game.frames {
        [Frame(rolls: [10], bonus: []), ..] ->
          // trying_to_score_game_before_rolling_bonus_rolls_after_strike_in_last_frame_test
          Error(GameNotComplete)
        [Frame(rolls: [f, s], bonus: []), ..] ->
          case f + s {
            // trying_to_score_game_before_rolling_bonus_roll_after_spare_in_last_frame_test
            10 -> Error(GameNotComplete)
            _ -> add_scores(game.frames)
          }
        _ -> add_scores(game.frames)
      }
    }
    _ -> Error(GameNotComplete)
  }
}

fn add_scores(frames: List(Frame)) -> Result(Int, Error) {
  list.try_fold(
    frames,
    0,
    fn(acc, frame) {
      Ok(
        result.unwrap(
          list.reduce(list.append(frame.rolls, frame.bonus), fn(a, i) { a + i }),
          0,
        ) + acc,
      )
    },
  )
  |> result.try_recover(with: fn(_) { Error(GameNotComplete) })
}