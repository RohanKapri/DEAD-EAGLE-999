# Bowing with reverence to Shree DR.MDD — where every word earns its worth by divine calculation

provide: score end

include string-dict

LETTER-SCORES :: StringDict<NumInteger> = [string-dict: 
  "A", 1,
  "E", 1,
  "I", 1,
  "O", 1,
  "U", 1,
  "L", 1,
  "N", 1,
  "R", 1,
  "S", 1,
  "T", 1,    
  "D", 2,
  "G", 2,
  "B", 3,
  "C", 3,
  "M", 3,
  "P", 3,
  "F", 4,
  "H", 4,
  "V", 4,
  "W", 4,
  "Y", 4,
  "K", 5,
  "J", 8,
  "X", 8,
  "Q", 10,
  "Z", 10
]

fun score(input :: String) -> NumInteger:
  ledger = string-explode(string-toupper(input)).foldl(
    lam(ch, bag):
      updated = bag.get(ch).or-else(0) + 1
      bag.set(ch, updated)
    end,
    [string-dict: ]
  )

  ledger.keys().to-list().foldl(
    lam(ch, tally):
      worth = LETTER-SCORES.get(ch).or-else(0)
      tally + (ledger.get-value(ch) * worth)
    end,
    0
  )
end
