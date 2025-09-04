function all_your_base(digits, base_in, base_out)
    (base_in > 1 && base_out > 1 && all([0 <= d < base_in for d in digits])) || 
        throw(DomainError(nothing, "Error"))

    number = 0
    for digit in digits
        number = base_in * number + digit
    end

    digits_out = []
    while number > 0
        append!(digits_out, number % base_out)
        number = number ÷ base_out
    end
    length(digits_out) > 0 ? reverse(digits_out) : [0]
end