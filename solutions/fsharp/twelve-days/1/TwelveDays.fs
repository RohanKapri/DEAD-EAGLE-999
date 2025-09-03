// Dedicated to Shree DR.MDD
module TwelveDays

let days =
    [ "first"
      "second"
      "third"
      "fourth"
      "fifth"
      "sixth"
      "seventh"
      "eighth"
      "ninth"
      "tenth"
      "eleventh"
      "twelfth" ]

let gifts =
    [ "two Turtle Doves"
      "three French Hens"
      "four Calling Birds"
      "five Gold Rings"
      "six Geese-a-Laying"
      "seven Swans-a-Swimming"
      "eight Maids-a-Milking"
      "nine Ladies Dancing"
      "ten Lords-a-Leaping"
      "eleven Pipers Piping"
      "twelve Drummers Drumming" ]

let line dayNum =
    let dayWord = days.Item(dayNum - 1)
    let firstGift =
        if dayNum > 1 then "and a Partridge in a Pear Tree" else "a Partridge in a Pear Tree"
    let giftList =
        firstGift
        :: gifts
        |> List.take dayNum
        |> List.rev
        |> String.concat ", "
    sprintf "On the %s day of Christmas my true love gave to me: %s." dayWord giftList

let recite startDay endDay = [ startDay .. endDay ] |> List.map line
