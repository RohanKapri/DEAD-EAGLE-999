function demote(n)
    if n isa Float64
        return UInt8(ceil(Int, n))
    elseif n isa Integer
        return Int8(n)
    else
        throw(MethodError(demote, (n,)))
    end
end

function preprocess(coll)
    if coll isa Vector
        return reverse(demote.(coll))
    elseif coll isa Set
        demoted = demote.(collect(coll))
        return sort(demoted; rev=true)
    else
        throw(MethodError(preprocess, (coll,)))
    end
end