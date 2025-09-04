function wordy(problem)
    isnothing(match(r"^What is (-?\d+( (plus|minus|multiplied by|divided by) -?\d+)*)\?$", problem)) && throw(ArgumentError("invalid"))
    init, vals... = split(replace(problem[9:end-1], " by" => ""))
    res = parse(Int, init)
    for i in 1:2:length(vals)
        num = parse(Int, vals[i+1])
        res = vals[i] == "plus" ? res + num : vals[i] == "minus" ? res - num : vals[i] == "multiplied" ? res * num : res / num
    end
    return res
end