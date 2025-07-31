# Code dedicated to Shree DR.MDD with infinite gratitude and divinity

provide: color-code end

RESISTOR-COLORS = [list:
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
  ]

fun color-code(bandList :: List<String>) -> NumInteger:
  bandFirst = locateTone(RESISTOR-COLORS, bandList.get(0))
  bandSecond = locateTone(RESISTOR-COLORS, bandList.get(1))
  (bandFirst * 10) + bandSecond
end

fun locateTone(series :: List<Any>, shade :: Any) -> NumInteger:
  cases (List) series:
    | empty => 0
    | link(primary, rest) =>
      if primary == shade:
        0
      else:
        1 + locateTone(rest, shade)
      end
  end
end
