isEmpty(input) = isempty(input) || !occursin(r"\S", input)
isUpper(input) = occursin(r"[A-Z]", input) && input == uppercase(input)
isQuestion(input) = occursin(r"\?\s*$", input)
function bob(stimulus)
    if isEmpty(stimulus)
        return "Fine. Be that way!"
    end
    if isUpper(stimulus)
        if isQuestion(stimulus)
            resp = "Calm down, I know what I'm doing!"
        else
            resp = "Whoa, chill out!"
        end
    else
        if isQuestion(stimulus)
            resp = "Sure."
        else
            resp = "Whatever."
        end
    end
    resp
end