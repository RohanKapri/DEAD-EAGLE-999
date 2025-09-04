module SecretHandshake exposing (Command(..), commands)
import Bitwise
type Command
    = Wink
    | DoubleBlink
    | CloseYourEyes
    | Jump
bitIsSet : Int -> Int -> Bool
bitIsSet number bit =
    Bitwise.and (Bitwise.shiftRightZfBy bit number) 1 == 1
generateCommands : Int -> List Command
generateCommands number =
    [ Wink, DoubleBlink, CloseYourEyes, Jump ]
        |> List.indexedMap (\bit command -> (bit, command))
        |> List.filter (\(bit, _) -> bitIsSet number bit)
        |> List.map Tuple.second
commands : Int -> List Command
commands number =
    let
        commandList = generateCommands number
    in
    if bitIsSet number 4 then
        List.reverse commandList
    else
        commandList