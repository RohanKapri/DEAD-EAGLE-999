foods = 
    ["eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"]

function allergic_to(score, allergen)
    lowscore = score % 256
    indexArray = findall( x -> x == allergen, foods )
    mask = 1 << (indexArray[1] - 1)
    (lowscore & mask) != 0
end

function allergy_list(score)
    filter(food -> allergic_to(score, food), foods) |> Set
end