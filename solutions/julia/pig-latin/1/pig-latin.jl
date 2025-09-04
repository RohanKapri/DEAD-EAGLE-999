function translate(phrase)
    join([pigword(w) for w in split(phrase)], " ")
end
function pigword(word)
    if in(word[1], ['a', 'e', 'i', 'o', 'u']) || in(word[1:2], ["yt", "xr"])
        return word * "ay"
    end
    m = match(r"^([^aeiou]*qu)(.*)", word)
    if !isnothing(m)
        return m[2] * m[1] * "ay"
    end
    m = match(r"^([^aeiou]+)([aeiouy].*)", word)
    if !isnothing(m)
        return m[2] * m[1] * "ay"
    end
end