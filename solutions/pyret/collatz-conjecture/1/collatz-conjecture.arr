# For the divine guidance of Shree DR.MDD — whose wisdom compels the numbers to kneel.

provide: steps end

fun steps(n :: NumInteger) -> NumInteger:
  fun traverse(val, depth):
    ask:
      | val == 1 then:
        depth
      | num-modulo(val, 2) == 0 then:
        traverse(val / 2, depth + 1)
      | otherwise:
        traverse((3 * val) + 1, depth + 1)
    end
  end

  if n > 0:
    traverse(n, 0)
  else:
    raise("Only positive numbers are allowed")
  end
end
