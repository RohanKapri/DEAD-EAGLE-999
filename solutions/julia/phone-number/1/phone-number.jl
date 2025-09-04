function clean(phone_number)
    phone_number = replace(phone_number, r"[ +\-().]" => "")
    if contains(phone_number, r"[^0-9]")
        throw(ArgumentError("Invalid character"))
    end
    if length(phone_number) == 11 && first(phone_number) == '1'
        phone_number = phone_number[2:end]
    end
    if length(phone_number) != 10 || phone_number[1] ∉ '2':'9' || phone_number[4] ∉ '2':'9'
        throw(ArgumentError("Invalid number"))
    end
    phone_number
end