module PaolasPrestigiousPizza exposing
    ( Pizza
    , ingredientsParser
    , menuParser
    , oneIngredientParser
    , pizzaParser
    , priceParser
    , vegetarianParser
    , wordParser
    )

import Parser exposing ((|.), (|=), Parser)


type alias Pizza =
    { name : String
    , vegetarian : Bool
    , ingredients : List String
    , price : Int
    }


priceParser : Parser Int
priceParser =
    Parser.succeed identity
        |= Parser.int
        |. Parser.symbol "€"



vegetarianParser : Parser Bool
vegetarianParser =
    Parser.oneOf
        [ Parser.succeed True
            |. Parser.symbol "(v)"
        , Parser.succeed False
        ]


wordParser : Parser String
wordParser =
    Parser.chompWhile Char.isAlpha
        |> Parser.getChompedString 
        |> Parser.map String.toLower


ingredientsParser : Parser (List String)
ingredientsParser =
    Parser.sequence
        { end = ""
        , item = oneIngredientParser
        , separator = ","
        , spaces = Parser.spaces
        , start = ""
        , trailing = Parser.Forbidden
        }


pizzaParser : Parser Pizza
pizzaParser =
    Parser.succeed Pizza
        |= wordParser
        |. Parser.spaces
        |= vegetarianParser
        |. Parser.symbol ":"
        |. Parser.spaces
        |= ingredientsParser
        |. Parser.spaces
        |. Parser.symbol "-"
        |. Parser.spaces
        |= priceParser
        


menuParser : Parser (List Pizza)
menuParser =
    Parser.sequence
        { end = ""
        , item = pizzaParser
        , separator = "\n"
        , spaces = Parser.chompWhile ((==) ' ')
        , start = ""
        , trailing = Parser.Optional
        }
        |. Parser.end


oneIngredientParser : Parser String
oneIngredientParser =
    let
        isAlphaOrSpace char =
            Char.isAlpha char || char == ' '

        hasSomeLength str =
            if String.length str > 0
            then Parser.succeed str
            else Parser.problem "empty string"
    in
    Parser.chompWhile isAlphaOrSpace
        |> Parser.getChompedString
        |> Parser.map (String.trim >> String.toLower)
        |> Parser.andThen hasSomeLength