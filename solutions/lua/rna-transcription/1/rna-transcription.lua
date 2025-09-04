return function(dna)
  return dna:gsub(".", function(a)
    return ({ G = "C", C = "G", T = "A", A = "U" })[a] or "?"
  end)
end