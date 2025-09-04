function matching_brackets(input)
    cleaned = join([c for c in input if c in "(){}[]"])
    while true
        old_len = length(cleaned)
        cleaned = replace(cleaned, "()"=>"")
        cleaned = replace(cleaned, "[]"=>"")
        cleaned = replace(cleaned, "{}"=>"")
        if length(cleaned) == old_len
            break
        end
    end
    cleaned == ""
end