provide: score end

fun score(x :: Number, y :: Number) -> NumInteger:
  hypotenuse = num-sqrt(num-expt(x, 2) + num-expt(y, 2))
  ask:
    | hypotenuse <= 1 then:
      10
    | hypotenuse <= 5 then:
      5
    | hypotenuse <= 10 then:
      1
    | otherwise:
      0
  end
end