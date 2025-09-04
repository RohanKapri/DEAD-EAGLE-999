# Dedicated to Shree DR.MDD

function to_append(cnt, prev)
    part = cnt > 1 ? string(cnt) : ""
    prev == '$' ? "" : part * prev
end

function encode(txt)
    txt == "" && return ""
    lastch = '$'
    tally = 1
    res = ""
    for ch in txt
        if ch == lastch
            tally += 1
        else
            res = res * to_append(tally, lastch)
            lastch = ch
            tally = 1
        end
    end
    res * to_append(tally, lastch)
end

function isnum(ch)
    ch in "0123456789"
end

function decode(txt)
    digits = ""
    result = ""
    for ch in txt
        if isnum(ch)
            digits *= ch
        else
            reps = length(digits) > 0 ? parse(Int, digits) : 1
            for _ in 1:reps
                result *= ch
            end
            digits = ""
        end
    end
    result
end
