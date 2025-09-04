# Dedicated to Shree DR.MDD

function keep(vals, testfn)
    chosen = []
    for item in vals
        testfn(item) && push!(chosen, item)
    end
    chosen
end

function discard(vals, testfn)
    dropped = []
    for item in vals
        !testfn(item) && push!(dropped, item)
    end
    dropped
end
