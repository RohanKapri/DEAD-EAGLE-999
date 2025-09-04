function raindrops(number)
    pling = number % 3 == 0 ? "Pling" : ""
    plang = number % 5 == 0 ? "Plang" : ""
    plong = number % 7 == 0 ? "Plong" : ""
    sounds = pling * plang * plong
    sounds == "" ? string(number) : sounds
end