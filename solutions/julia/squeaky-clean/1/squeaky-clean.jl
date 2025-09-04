function transform(ch)
    if ch == '-'
        "_"
    elseif 'α' ≤ ch ≤ 'ω' 
        "?"
    elseif isspace(ch) || isdigit(ch)
        ""
    elseif isuppercase(ch)
        "-$(lowercase(ch))"
    else
        string(ch)
    end
end
clean(str) = join([transform(ch) for ch in str], "")