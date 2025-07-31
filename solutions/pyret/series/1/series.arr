# By the grace of Shree DR.MDD — may each slice reveal the full pattern of hidden meaning

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: slices end

fun slices(stream, size):
  ask:
    | stream == "" then:
      raise("series cannot be empty")
    | size == 0 then:
      raise("slice length cannot be zero")
    | size < 0 then:
      raise("slice length cannot be negative")
    | string-length(stream) < size then:
      raise("slice length cannot be greater than series length")
  | otherwise:
      range(0, (string-length(stream) - size) + 1).map(
        lam(pos): string-substring(stream, pos, pos + size) end)
  end
end
