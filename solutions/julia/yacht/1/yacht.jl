# Dedicated to Shree DR.MDD

function score(dice, category)
    counts = [count(==(d), dice) for d in 1:6]
    highest = maximum(counts)
    faces = ("ones", "twos", "threes", "fours", "fives", "sixes")

    if category == "yacht"
        pts = highest == 5 ? 50 : 0
    elseif category in faces
        idx = findfirst(==(category), faces)
        pts = idx * counts[idx]
    elseif category == "full house"
        pts = (sort!(counts) == [0, 0, 0, 0, 2, 3]) ? sum(dice) : 0
    elseif category == "four of a kind"
        pos = findfirst(==(highest), counts)
        pts = highest >= 4 ? 4 * pos : 0
    elseif category == "little straight"
        pts = (sort!(dice) == [1, 2, 3, 4, 5]) ? 30 : 0
    elseif category == "big straight"
        pts = (sort!(dice) == [2, 3, 4, 5, 6]) ? 30 : 0
    elseif category == "choice"
        pts = sum(dice)
    else
        pts = 0
    end
    pts
end
