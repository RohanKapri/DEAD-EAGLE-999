module MonsterAttack exposing (..)

type alias MonsterDamage = String


-- Functions for test 1
attackWithSword1 : MonsterDamage -> Int -> MonsterDamage
attackWithSword1 damage strength =
    damage ++ "Attacked with sword of strength " ++ String.fromInt strength ++ "."

attackWithClaw1 : MonsterDamage -> Int -> MonsterDamage
attackWithClaw1 damage strength =
    damage ++ "Attacked with claw of strength " ++ String.fromInt strength ++ "."

attack1 : MonsterDamage -> MonsterDamage
attack1 damage =
    let
        annalyn = \md -> attackWithSword1 md 5
        kazak = \md -> attackWithClaw1 md 1
    in
    damage
        |> annalyn
        |> kazak
        |> kazak
        |> annalyn


-- Functions for test 2
attackWithSword2 : Int -> MonsterDamage -> MonsterDamage
attackWithSword2 strength damage =
    damage ++ "Attacked with sword of strength " ++ String.fromInt strength ++ "."

attackWithClaw2 : Int -> MonsterDamage -> MonsterDamage
attackWithClaw2 strength damage =
    damage ++ "Attacked with claw of strength " ++ String.fromInt strength ++ "."

attack2 : MonsterDamage -> MonsterDamage
attack2 damage =
    let
        annalyn = attackWithSword2 5
        kazak = attackWithClaw2 1
    in
    damage
        |> annalyn
        |> kazak
        |> kazak
        |> annalyn


-- Composed attack sequence
attack3 : MonsterDamage -> MonsterDamage
attack3 =
    attackWithSword2 5
        >> attackWithClaw2 1
        >> attackWithClaw2 1
        >> attackWithSword2 5
