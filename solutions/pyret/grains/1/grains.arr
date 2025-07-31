provide: on-square, total end

fun on-square(n :: NumInteger) -> NumInteger:
  ask:
    | (n >= 1) and (n <= 64) then:
      num-expt(2, (n - 1))
    | otherwise:
      raise("square must be between 1 and 64")
  end
end

fun total() -> NumInteger:
  num-expt(2, 64) - 1
end