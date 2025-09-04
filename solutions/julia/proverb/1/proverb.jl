function recite(pieces::Vector)
    n = length(pieces)
    if n == 0
        return ""
    elseif n == 1
        return "And all for the want of a $(pieces[1])."
    else
        lines = String[]
        for i in 1:(n-1)
            push!(lines, "For want of a $(pieces[i]) the $(pieces[i+1]) was lost.")
        end
        push!(lines, "And all for the want of a $(pieces[1]).")
        return join(lines, "\n")
    end
end