function trinary_to_decimal(str::AbstractString)
    ternarydigits = str |> to_digits |> y -> filter(x -> x < 3, y)
    if length(str) > length(ternarydigits)
        return 0
    end
    sum(ternarydigits .* [3 ^ i for i = length(ternarydigits) -1 : -1 : 0])
end

function to_digits(str::AbstractString)
    [parse(Int64, x) for x = str if isdigit(x)]
end