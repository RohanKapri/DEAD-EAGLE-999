function to_roman(number)
    number > 0 || throw(ErrorException("Invalid input"))      
    table = (
        ("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"),
        ("X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"),
        ("C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"),
        ("M", "MM", "MMM"))
    digs = reverse(digits(number))
    inv = length(digs) + 1
    
    join(table[inv - i][d] for (i, d) in enumerate(digs) if d != 0)
end