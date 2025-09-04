local values = {
  ["M"] = 1000, ["CM"] = 900, ["D"] = 500, ["CD"] = 400,
  ["C"] = 100, ["XC"] = 90, ["L"] = 50, ["XL"] = 40,
  ["X"] = 10, ["IX"] = 9, ["V"] = 5, ["IV"] = 4, ["I"] = 1 
};
local numerals = { "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I" }
    
return {
    to_roman = function(n)
        local result = {};
        for _, numeral in ipairs(numerals) do
            while n >= values[numeral] do
                table.insert(result, numeral)
                n = n - values[numeral]
            end
        end
        return table.concat(result, '')
    end
}