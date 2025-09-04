const transdict = zip('a':'z', reverse('a':'z')) |> Dict

function encode(input)
    ciphered = replace(lowercase(input), r"\W" => "") |> translate
    join(split5([], ciphered), " ")
end

decode(input) = replace(input, " " => "") |> translate

translate(input) = map(c -> haskey(transdict, c) ? transdict[c] : c, input)

split5(bits, rest) = length(rest) <= 5 ? push!(bits, rest) :
                        split5(push!(bits, rest[1:5]), rest[6:end])