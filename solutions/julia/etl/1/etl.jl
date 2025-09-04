function transform(input::AbstractDict)
    output = Dict{Char, Int}()
    for (k, v) in input
        for letter in v
            output[lowercase(letter)] = k
        end
    end
    output
end