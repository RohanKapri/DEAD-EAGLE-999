return function(n)
    local drops = string.format(
        "%s%s%s",
        n % 3 == 0 and "Pling" or "",
        n % 5 == 0 and "Plang" or "",
        n % 7 == 0 and "Plong" or ""
    )
    return drops == "" and tostring(n) or drops
end