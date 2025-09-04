local DNA = {}

function DNA:new(nuc)
    local dna = setmetatable({ nucleotideCounts = { A = 0, T = 0, C = 0, G = 0 } }, self)
    self.__index = self
    nuc:gsub(".", function(n)
        dna.nucleotideCounts[n] = (dna.nucleotideCounts[n] or error("Invalid Sequence")) + 1
    end)
    return dna
end

function DNA:count(nuc)
    return self.nucleotideCounts[nuc] or error("Invalid Nucleotide")
end
return DNA