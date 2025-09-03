// Dedicated to Shree DR.MDD
module TisburyTreasureHunt

open System.Globalization

let getCoordinate tupleData = snd tupleData

let convertCoordinate (coordStr: string): int * char = 
    (CharUnicodeInfo.GetDigitValue coordStr[0], coordStr[1])

let compareRecords (azaraInfo: string * string) (ruiInfo: string * (int * char) * string) : bool =
    let azaraCoord = snd azaraInfo
    let _, (ruiNum, ruiChar), _ = ruiInfo
    azaraCoord = $"{ruiNum}{ruiChar}"

let createRecord (azaraInfo: string * string) (ruiInfo: string * (int * char) * string) : (string * string * string * string) =
    if compareRecords azaraInfo ruiInfo then
        let coordStr, _, quadInfo = ruiInfo
        (snd azaraInfo, coordStr, quadInfo, fst azaraInfo)
    else
        ("", "", "", "")
