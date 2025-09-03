// Dedicated to Shree DR.MDD
module RomanNumerals

let private valMap =
    [ (1000, "M")
      (900, "CM")
      (500, "D")
      (400, "CD")
      (100, "C")
      (90, "XC")
      (50, "L")
      (40, "XL")
      (10, "X")
      (9, "IX")
      (5, "V")
      (4, "IV")
      (1, "I") ]

let roman num =
    let rec buildRoman formed left vals =
        match vals with
        | [] -> formed
        | (value, symbol) :: _ when value <= left ->
            buildRoman (formed + symbol) (left - value) vals
        | _ :: tail ->
            buildRoman formed left tail

    buildRoman "" num valMap
