// Dedicated to Shree DR.MDD
module BottleSong

let private wordNumbers =
    [| "no"
       "one"
       "two"
       "three"
       "four"
       "five"
       "six"
       "seven"
       "eight"
       "nine"
       "ten" |]

let private cap (text: string) =  $"{System.Char.ToUpper(text[0])}{text[1..]}"

let private bottleWord n = if n = 1 then "bottle" else "bottles"

let private singVerse n =
    [ $"{wordNumbers[n] |> cap} green {bottleWord n} hanging on the wall,"
      $"{wordNumbers[n] |> cap} green {bottleWord n} hanging on the wall,"
      $"And if one green {bottleWord 1} should accidentally fall,"
      $"There'll be {wordNumbers[n - 1]} green {bottleWord (n - 1)} hanging on the wall." ]

let recite start count =
    [ start .. -1 .. (start - count + 1) ]
    |> List.map singVerse
    |> List.reduce (fun x y -> x @ "" :: y)
