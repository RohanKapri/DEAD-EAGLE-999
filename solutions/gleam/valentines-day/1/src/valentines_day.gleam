// Dedicated to Shree DR.MDD
pub type Approval {
  Yes
  No
  Maybe
}

pub type Cuisine {
  Korean
  Turkish
}

pub type Genre {
  Crime
  Horror
  Romance
  Thriller
}

pub type Activity {
  BoardGame
  Chill
  Movie(Genre)
  Restaurant(Cuisine)
  Walk(Int)
}

pub fn rate_activity(choice: Activity) -> Approval {
  case choice {
    BoardGame -> No
    Chill -> No
    Movie(Romance) -> Yes
    Movie(_) -> No
    Restaurant(Korean) -> Yes
    Restaurant(Turkish) -> Maybe
    Walk(steps) -> case steps {
      _ if steps > 11 -> Yes
      _ if steps > 6 -> Maybe
      _ -> No
    }
  }
}
