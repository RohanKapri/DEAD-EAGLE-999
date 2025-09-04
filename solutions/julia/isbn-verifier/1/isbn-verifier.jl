struct ISBN
    s::Any
    function ISBN(s)
        ds = [replace(s, "-" => "")...] .- '0'
        length(ds) == 10 || throw(DomainError(s))
        ds[end] %= 30
        all(@. 0 <= ds <= 10) && sum(ds .* (10:-1:1)) % 11 == 0 || throw(DomainError(s))
        return new(ds)
    end
end

Base.:(==)(x::ISBN, y::ISBN) = x.s == y.s