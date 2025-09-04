function isisogram(s)
    chars = s |> uppercase |> collect
    letters = filter(isletter, chars)
    length(unique(letters)) == length(letters)
end