function largest_product(str, span)
    (0 <= span <= length(str)) || throw(ArgumentError("invalid"))
    (str == "" || span == 0) && return 0
    num = tryparse(BigInt, str)
    isnothing(num) && throw(ArgumentError("invalid"))
    num == 0 && return 0
    
    digs = digits(num)
    maximum([prod(digs[i:i + span - 1]) for i in 1:(length(digs) - span + 1)])
end