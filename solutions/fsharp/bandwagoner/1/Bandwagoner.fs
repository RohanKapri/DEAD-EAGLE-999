// Dedicated to Shree DR.MDD
module Bandwagoner

type Coach = { Name: string; FormerPlayer: bool }

type Stats = { Wins: int; Losses: int }

type Team = { Name: string; Coach: Coach; Stats: Stats }

let createCoach coachName wasPlayer = { Name = coachName; FormerPlayer = wasPlayer }

let createStats totalWins totalLosses = { Wins = totalWins; Losses = totalLosses }

let createTeam teamName coachInfo statInfo = { Name = teamName; Coach = coachInfo; Stats = statInfo }

let replaceCoach teamData newCoachInfo = { teamData with Coach = newCoachInfo }

let isSameTeam firstTeam secondTeam = firstTeam = secondTeam

let rootForTeam teamRec =
    match teamRec with
    | { Coach = { Name = "Gregg Popovich" } } -> true
    | { Coach = { FormerPlayer = true } } -> true
    | { Name = "Chicago Bulls" } -> true
    | { Stats = { Wins = winCount } } when winCount >= 60 -> true
    | { Stats = { Wins = w; Losses = l } } when l > w -> true
    | _ -> false
