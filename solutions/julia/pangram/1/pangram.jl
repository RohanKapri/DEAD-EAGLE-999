"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""

function allin(input)
    # assumes non-empty, lower case input
    
    for c in 'a':'z'
        if !contains(input, c)
            return false
        end
    end
    return true
end

function ispangram(input)
    input == "" ? false : allin(lowercase(input))
end