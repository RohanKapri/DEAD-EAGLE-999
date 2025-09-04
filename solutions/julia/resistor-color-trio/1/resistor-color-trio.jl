function label(colors)
    cols = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]
    res = ""
    d = Dict(cols[a+1] => a for a in 0:9)
    val = (d[colors[1]]*10 + d[colors[2]]) * 10^d[colors[3]]
    if val > 1e9
        hold = (val/1e9)
        if isinteger(hold)
            hold = Int(hold)
        end            
        res = "$hold gigaohms"
    elseif val > 1e6
        hold = (val/1e6)
        if isinteger(hold)
            hold = Int(hold)
        end            
        res = "$hold megaohms"
    elseif val > 1e3
        hold = (val/1e3)
        if isinteger(hold)
            hold = Int(hold)
        end            
        res = "$hold kiloohms"
    else
        res = "$(val) ohms"
    end
    res
end