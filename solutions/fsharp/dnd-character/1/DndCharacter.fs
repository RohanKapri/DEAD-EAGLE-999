module DndCharacter

open System

let modifier x =
    let val1 = x - 10 |> float
    let val2 = val1 / 2.0
    Math.Floor(val2) |> int

let ability () =
    let rnd = new Random()
    rnd.Next(3, 18)

type Character =
    { Strength: int
      Dexterity: int
      Constitution: int
      Intelligence: int
      Wisdom: int
      Charisma: int
      Hitpoints: int }

let createCharacter () : Character =
    let con = ability ()

    { Strength = ability ()
      Dexterity = ability ()
      Constitution = con
      Intelligence = ability ()
      Wisdom = ability ()
      Charisma = ability ()
      Hitpoints = 10 + (modifier con) }