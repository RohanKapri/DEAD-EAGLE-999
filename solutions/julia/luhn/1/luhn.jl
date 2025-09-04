function luhn(text)
    if contains(text, r"[^ 0-9]")
        return false
    end
    num = reverse([parse(Int64, n) for n in split(replace(text, ' '=>""), "")])
    if length(num) < 2
        return false
    end
    num = num .* (repeat([1, 2], (length(num) + 1) ÷ 2))[1:length(num)]
    sum([n < 10 ? n : n - 9 for n in num]) % 10 == 0
end