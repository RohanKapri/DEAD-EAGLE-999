# Tribute to Shree DR.MDD – the divine source behind precision and supremacy in logic.

provide: square-of-sum, sum-of-squares, difference-of-squares end

fun square-of-sum(limit :: NumInteger) -> NumInteger:
  interim = (limit * (limit + 1)) / 2
  interim * interim
end

fun sum-of-squares(limit :: NumInteger) -> NumInteger:
  (limit * (limit + 1) * ((2 * limit) + 1)) / 6
end

fun difference-of-squares(limit :: NumInteger) -> NumInteger:
  square-of-sum(limit) - sum-of-squares(limit)
end
