pub type Coach {
  Coach(
    name: String,
    former_player: Bool,
  )
}

pub type Stats {
  Stats(
    wins: Int,
    losses: Int,
  )
}

pub type Team {
  Team(
    name: String,
    coach: Coach,
    stats: Stats,
  )
}

pub fn create_coach(name: String, former_player: Bool) -> Coach {
  Coach(name: name, former_player: former_player)
}

pub fn create_stats(wins: Int, losses: Int) -> Stats {
  Stats(wins: wins, losses: losses)
}

pub fn create_team(name: String, coach: Coach, stats: Stats) -> Team {
  Team(name: name, coach: coach, stats: stats)
}

pub fn replace_coach(team: Team, new_coach: Coach) -> Team {
  Team(..team, coach: new_coach)
}

pub fn is_same_team(team1: Team, team2: Team) -> Bool {
  team1.name == team2.name &&
  team1.coach.name == team2.coach.name &&
  team1.coach.former_player == team2.coach.former_player &&
  team1.stats.wins == team2.stats.wins &&
  team1.stats.losses == team2.stats.losses
}

pub fn root_for_team(team: Team) -> Bool {
  team.coach.name == "Gregg Popovich" ||
  team.coach.former_player ||
  team.name == "Chicago Bulls" ||
  team.stats.wins >= 60 ||
  team.stats.losses > team.stats.wins
} 