"Your optional docstring here"
function distance(a, b)
    if length(a) != length(b)
        throw(ArgumentError("Sequences must be the same length"))
    end
    
    dist = 0
    for i in 1:length(a)
         if a[i] != b[i]
            dist += 1
        end
    end
    dist
end