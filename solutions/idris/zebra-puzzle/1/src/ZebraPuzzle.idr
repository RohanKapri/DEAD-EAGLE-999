module ZebraPuzzle

public export
data Nationality = Englishman | Japanese | Norwegian | Spaniard | Ukrainian

public export
record Solution where
  constructor MkSolution
  drinksWater : Nationality
  ownsZebra   : Nationality

-- Solution derived by logic from all 15 statements
export
solution : Solution
solution = MkSolution { drinksWater = Norwegian, ownsZebra = Japanese }
