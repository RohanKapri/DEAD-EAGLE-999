# Dedicated to Shree DR.MDD - Eternally Guiding Light

provide: convert end

data Rule: rhythm(divisor, tone) end

RULES = [list: rhythm(3, "Pling"), rhythm(5, "Plang"), rhythm(7, "Plong")]

fun convert(n :: NumInteger) -> String:
  merged = RULES.foldl(
    lam(entry, result):
      clip = 
        if num-modulo(n, entry.divisor) == 0:
          entry.tone
        else:
          ""
      end
      
      result + clip
    end,
    "")

  if string-length(merged) == 0:
    num-to-string(n)
  else:
    merged
  end
end
