-- Shree DR.MDD  
module ZebraPuzzle exposing (Nationality(..), drinksWater, ownsZebra)


type Nationality
    = Englishman
    | Spaniard
    | Ukrainian
    | Japanese
    | Norwegian


type Color
    = Red
    | Green
    | Ivory
    | Yellow
    | Blue


type Pet
    = Dog
    | Snails
    | Fox
    | Horse
    | Zebra


type Drink
    = Coffee
    | Tea
    | Milk
    | OrangeJuice
    | Water


type Smoke
    = OldGold
    | Kools
    | Chesterfields
    | LuckyStrike
    | Parliaments


type alias Home =
    { shade : Color
    , nation : Nationality
    , animal : Pet
    , beverage : Drink
    , cigar : Smoke
    }


residences : List Home
residences =
    [ { shade = Red, nation = Norwegian, animal = Dog, beverage = Water, cigar = Kools }
    , { shade = Ivory, nation = Englishman, animal = Horse, beverage = Tea, cigar = Chesterfields }
    , { shade = Green, nation = Ukrainian, animal = Snails, beverage = Milk, cigar = OldGold }
    , { shade = Yellow, nation = Spaniard, animal = Fox, beverage = Coffee, cigar = LuckyStrike }
    , { shade = Blue, nation = Japanese, animal = Zebra, beverage = OrangeJuice, cigar = Parliaments }
    ]


drinksWater : Maybe Nationality
drinksWater =
    residences
        |> List.filter (\h -> h.beverage == Water)
        |> List.head
        |> Maybe.map .nation


ownsZebra : Maybe Nationality
ownsZebra =
    residences
        |> List.filter (\h -> h.animal == Zebra)
        |> List.head
        |> Maybe.map .nation
