ChristmasGifts ← |1.2 {
  "a Partridge in a Pear Tree"
  "two Turtle Doves"
  "three French Hens"
  "four Calling Birds"
  "five Gold Rings"
  "six Geese-a-Laying"
  "seven Swans-a-Swimming"
  "eight Maids-a-Milking"
  "nine Ladies Dancing"
  "ten Lords-a-Leaping"
  "eleven Pipers Piping"
  "twelve Drummers Drumming"
}

OrdinalDays ← |1.2 {
  "first"
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
  "twelfth"
}

FormatGifts ← |1 ⍜⊜∘≡⋅", and a" ⦷ ", a". /$"_, _" ≡(⊡:ChristmasGifts)⇌⇡+1

GetOrdinalDay ← |1 ⊡:OrdinalDays

BuildVerse ← |1 $"On the _ day of Christmas my true love gave to me: _." ⊃(GetOrdinalDay|FormatGifts)

Recite ← |2 ≡(□BuildVerse) ⍜-⇡-1
