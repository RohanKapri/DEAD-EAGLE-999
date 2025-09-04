function palindromeproducts(low::Int, high::Int, smallest::Bool)
    low > high && throw(ArgumentError("low must be <= high"))

    factors = low:high
    products = smallest ? (low^2:high^2) : (high^2:-1:low^2)

    for p in products
        if string(p) == reverse(string(p))
            facts = [[f, p ÷ f] for f in factors if f*f <= p && p % f == 0 && p ÷ f in factors]
            isempty(facts) || return p, facts
        end
    end

    return nothing, []
end